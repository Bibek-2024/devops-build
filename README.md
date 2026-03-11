🛒 ReactJS E-Commerce DevOps Project
Project Goal: Deploy a React application to a production-ready state with a fully automated CI/CD pipeline and monitoring.

📌 Project Overview
Application: ReactJS E-commerce

Environment: AWS EC2 (t2.micro)

Port: 80 (HTTP)

Source Code: sriram-R-krishnan/devops-build

🏗 Pipeline Architecture
(Insert the colorful diagram I generated for you here)

🛠 Project Components
1. Dockerization
Dockerfile: Multi-stage build using Nginx (Alpine) to serve the React application on Port 80.

Docker Compose: Orchestrates the application container alongside the monitoring stack.

Optimization: Includes .dockerignore to keep images lightweight.

2. Automation (Bash Scripting)
scripts/build.sh: Automates the creation of Docker images.

scripts/deploy.sh: Manages container deployment and environment cleanup.

3. CI/CD with Jenkins
Type: Multibranch Pipeline (Pipeline-as-Code).

Triggers: Automatic build trigger via GitHub Webhooks.

Branching Strategy:

dev branch: Builds and pushes images to Public Docker Hub (bibekdec2022/dev).

main branch: Builds and pushes images to Private Docker Hub (bibekdec2022/prod).

Git: All version control handled strictly via Git CLI.

4. AWS Infrastructure
Instance: Ubuntu 24.04 on t2.micro.

Security Group Rules:

Port 80 (HTTP): Open to 0.0.0.0/0.

Port 22 (SSH): Restricted to Admin IP.

5. Monitoring & Health Checks
Stack: Prometheus, Grafana, Blackbox Exporter, Node Exporter, and cAdvisor.

Health Status: 24/7 endpoint monitoring via Blackbox probe.

Notifications: Configured Gmail SMTP alerting to send emails if probe_success < 1.

🚀 How to Run and Test
Clone the Repo: git clone https://github.com/Bibek-2024/devops-build.git

Build: ./scripts/build.sh

Deploy: ./scripts/deploy.sh

Access: Visit http://<EC2-IP>:80

📽 Live Demonstration
(Insert your video thumbnail link here once recorded)
