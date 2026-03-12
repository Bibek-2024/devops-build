```markdown
<h1 align="center">🛒 ReactJS E-Commerce DevOps Project</h1>

<p align="center">
  <img src="https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white" />
  <img src="https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white" />
  <img src="https://img.shields.io/badge/jenkins-%23D24939.svg?style=for-the-badge&logo=jenkins&logoColor=white" />
  <img src="https://img.shields.io/badge/prometheus-e6522c?style=for-the-badge&logo=prometheus&logoColor=white" />
  <img src="https://img.shields.io/badge/grafana-%23F46800.svg?style=for-the-badge&logo=grafana&logoColor=white" />
</p>

<p align="center">
  <strong>Automating the Deployment & Monitoring of a Production-Grade React Application on AWS.</strong>
</p>

---

## 📌 Table of Contents
- [Overview](#-overview)
- [Tools & Technologies](#-tools--technologies)
- [Project Structure](#-project-structure)
- [Pipeline Architecture](#-pipeline-architecture)
- [CI/CD Branching Strategy](#-cicd-branching-strategy)
- [Monitoring & Observability](#-monitoring--observability)
- [How to Run This Project](#-how-to-run-this-project)
- [Author & Contact](#-author--contact)

---

## 📖 Overview
This project showcases a complete DevOps lifecycle for a ReactJS application hosted on AWS. It implements a **Pipeline-as-Code** model using Jenkins, ensuring that every code push is automatically validated, containerized, and deployed with zero manual intervention.

---

## 🛠 Tools & Technologies

| Category | Tools Used |
| :--- | :--- |
| **Cloud Infrastructure** | AWS EC2 (t2.micro), Security Groups, IAM |
| **Containerization** | Docker, Docker Compose, Multi-stage Builds |
| **CI/CD Automation** | Jenkins (Multibranch), GitHub Webhooks |
| **Web Server** | Nginx (Alpine-optimized) |
| **Observability** | Prometheus, Grafana, Blackbox Exporter |
| **Scripting** | Bash (Shell Automation) |

---

## 📂 Project Structure
```text
.
├── Jenkinsfile            # CI/CD Pipeline definition
├── README.md              # Project Documentation
├── build/                 # Production-ready React assets (Minified)
├── docker/                # Container orchestration files
│   ├── Dockerfile         # Multi-stage build (Alpine + Nginx)
│   └── docker-compose.yml # App + Monitoring stack
├── images/                # Documentation & Architecture assets
├── monitoring/            # Scrape configs for Prometheus/Blackbox
│   ├── blackbox.yml
│   └── prometheus.yml
├── nginx.conf             # Custom Nginx proxy configuration
└── scripts/               # Automation & CI/CD helpers
    ├── build.sh           # Docker image build logic
    ├── deploy.sh          # EC2 deployment automation
    └── health-check.sh    # Post-deployment validation

```

---

## 🏗️ Pipeline Architecture

The diagram below illustrates the flow from a developer's machine to the live production server.

<p align="center">
<img src="./images/ReactJS%20E-Commerce%20DevOps%20Project%20Architecture%20Diagram.png" alt="Architecture Diagram" width="850">
</p>

### **CI/CD Execution Flow**

> **Developer Commit** ➔ **GitHub Webhook** ➔ **Jenkins Pipeline** ➔ **Docker Hub** ➔ **AWS EC2**

---

## 🚀 CI/CD Branching Strategy

We follow a strict branching model to isolate development changes from the production environment, ensuring stability and rapid deployment.

| Environment | Branch | Docker Hub Repository | Visibility |
| --- | --- | --- | --- |
| <img src="https://img.shields.io/badge/-Production-green?style=flat-square" /> | `main` | `bibekdec2022/prod` | 🔒 Private |
| <img src="https://img.shields.io/badge/-Staging-blue?style=flat-square" /> | `dev` | `bibekdec2022/dev` | 🌍 Public |

### **Workflow Guidelines**

* **Git CLI Standard:** All version control operations are managed strictly via the command line to maintain a clean and linear commit history.
* **Automated Tagging:** The Jenkins pipeline automatically applies version tags to Docker images based on the specific build number.

---

## 📊 Monitoring & Observability

We implemented a proactive monitoring strategy to track the health of the E-commerce platform:

* **Uptime Tracking:** Using Blackbox Exporter to probe Port 80.
* **Alerting:** Configured Gmail SMTP via Prometheus Alertmanager for instant "Site Down" notifications.
* **Dashboards:** Real-time visualization of CPU, Memory, and Network traffic in Grafana.

---

## ⚙️ How to Run This Project

### 1. Clone & Initialize

```bash
git clone [https://github.com/Bibek-2024/devops-build.git](https://github.com/Bibek-2024/devops-build.git)
cd devops-build

```

### 2. Execution Permissions

```bash
chmod +x scripts/build.sh scripts/deploy.sh

```

### 3. Deploy Stack

```bash
# This starts the React App, Prometheus, and Grafana
docker-compose up -d --build

```

---

## 👤 Author & Contact

### **Bibek Kumar Sahu**

*Aspiring DevOps & Cloud Infrastructure Engineer*

📫 **Email:** [bibekkumarsahu2011@gmail.com](mailto:bibekkumarsahu2011@gmail.com)
🔗 **LinkedIn:** [bibekkumarsahu](https://www.linkedin.com/in/bibekkumarsahu/)
📁 **GitHub:** [Bibek-2024](https://www.google.com/search?q=https://github.com/Bibek-2024)

---
