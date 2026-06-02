terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# --- Resources ---

# Use the existing image we built previously
data "docker_image" "web_image" {
  name = "cctv-simulator-web:latest"
}

# Pull the Nginx image
resource "docker_image" "nginx_image" {
  name = "nginx:1.27-alpine"
}

# Create a custom Docker network so containers can communicate by name
resource "docker_network" "cctv_net" {
  name = "cctv-simulator-net"
}

# Flask Web / Simulator Container
resource "docker_container" "web" {
  name  = "cctv-simulator"
  image = data.docker_image.web_image.name
  restart = "unless-stopped"
  
  networks_advanced {
    name = docker_network.cctv_net.name
    aliases = ["web"]
  }

  # RTSP Streams
  ports {
    internal = 8554
    external = 8554
    protocol = "tcp"
  }
  ports {
    internal = 8554
    external = 8554
    protocol = "udp"
  }

  # MediaMTX REST API
  ports {
    internal = 9997
    external = 9997
    protocol = "tcp"
  }

  volumes {
    host_path      = "/Users/ojayodon/Developer/cctv-simulator/test-video-tokyo-walking.mp4"
    container_path = "/opt/cctv-simulator/videos/camera.mp4"
    read_only      = true
  }
}

# Nginx Reverse Proxy Container
resource "docker_container" "nginx" {
  name  = "cctv-nginx"
  image = docker_image.nginx_image.name
  restart = "unless-stopped"

  networks_advanced {
    name = docker_network.cctv_net.name
  }

  ports {
    internal = 80
    external = 5050
    protocol = "tcp"
  }

  volumes {
    host_path      = "/Users/ojayodon/Developer/cctv-simulator/nginx.conf"
    container_path = "/etc/nginx/nginx.conf"
    read_only      = true
  }

  # Ensure the web container starts first
  depends_on = [docker_container.web]
}
