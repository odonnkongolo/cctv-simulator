**📄 CCTV Simulator Deployment Guide
**
**Prerequisite
**
1. Download and install Docker Desktop for Mac or Windows.
2. Ensure it is running before starting.


**Get the Code
**
1. Clone the repository to your machine (or extract the provided project ZIP archive):

_git clone https://github.com/YourUsername/cctv-simulator.git
cd cctv-simulator_

3. Add Your Video Source Drop any testing .mp4 video into the root directory and rename it to 'test-video-tokyo-walking.mp4'.

(Alternatively, they can modify the volume path in docker-compose.yml to point to their own video file).  


**Fire It Up
**
1. Run this single command in your terminal to automatically build and launch the environment:

_docker compose up -d
_
2. Control the Streams. Open your browser and navigate to http://localhost:5050 to access the control panel.
3. Input your desired Camera Count and hit Apply Changes.
4. Click ▶ Start Simulator.


You can now connect your NVR or VMS test platform to the local streams using the URL format: rtsp://localhost:8554/cam1
