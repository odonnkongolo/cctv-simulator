# 📹 CCTV IP Camera Simulator

### 🎛️ Management Dashboard

A secure, containerized Linux-based utility designed to simulate repeatable RTSP camera streams for VMS/NVR testing (such as exacqVision) without requiring physical hardware. Built using **MediaMTX** as the core RTSP server, **FFmpeg** for video looping processing, and a custom **Flask** web interface wrapped in an **Nginx** reverse proxy.

---

## 🏗️ System Architecture

```text
       [ NVR / VMS Client ]               [ Web Browser ]
               |                                 |
        (RTSP Port 8554)                  (HTTP Port 5050)
               v                                 v
+-------------------------------------------------------------+
|    Docker Container / Terraform Local State Managed Pod     |
|                                                             |
|  +-----------------------+       +-----------------------+  |
|  | MediaMTX RTSP Engine  |       |  Nginx Reverse Proxy  |  |
|  |      (Port 8554)      |       |  (Port 80 -> 5050)    |  |
|  +-----------------------+       +-----------------------+  |
|              ^                                 |            |
|              | (Feeds Streams)                 v (Internal) |
|  +-----------------------+       +-----------------------+  |
|  |  FFmpeg Video Loops   |       |   Flask Control Web   |  |
|  |  (pgrep -c ffmpeg)    |<------+ Dashboard (web_gui)   |  |
|  +-----------------------+       +-----------------------+  |
+-------------------------------------------------------------+
```

---

## ✨ Core Features

*   **🔒 Session-Based Authentication:** Secured behind a beautiful, dark-themed login portal matching the uniform system style.
*   **⚙️ Dynamic Stream Configuration:** Real-time generation of custom camera counts (1–180+) with full pagination handling for massive configurations.
*   **☁️ Infrastructure-as-Code Native:** Zero manual workspace configurations required; can be provisioned entirely through Terraform.
*   **🚀 Automated Delivery:** Integrated with GitHub Actions CI/CD to lint Python scripts and compile Docker images automatically.

---

## 🚀 Getting Started (Choose Your Method)

### 🐳 Option A: Quick QA Deployment (Docker Compose)
*Ideal for standard testing and validation cycles.*

1. Ensure Docker Desktop is running on your machine.
2. Add your reference MP4 file to the root workspace directory as `test-video-tokyo-walking.mp4`.
3. Fire up the entire stack with a single command:
   ```bash
   docker compose up -d
   ```

### 🌍 Option B: Enterprise GitOps Provisioning (Terraform)
*Ideal for infrastructure engineers who want declarative lifecycle management.*

1. Initialize the required local Docker providers:
   ```bash
   terraform init
   ```
2. Verify the execution blueprint:
   ```bash
   terraform plan
   ```
3. Provision and deploy the environment:
   ```bash
   terraform apply -auto-approve
   ```

---

## 💻 Interacting with the Tool

| Target Resource | Access Location | Purpose |
| :--- | :--- | :--- |
| **Control Panel** | [http://localhost:5050](http://localhost:5050) | Access dashboard to adjust camera settings and toggle state. |
| **RTSP Target URL** | `rtsp://localhost:8554/cam1` | Target format to paste directly into your NVR connection window. |
| **Default User** | `admin` | Default username credential for the session login shield. |
| **Default Password** | `Exacq11955!` | Default password credential for the session login shield. |

---

## 👨‍💻 Maintainers

**Odon Nkongolo** — *Lead Infrastructure Automation Engineer*