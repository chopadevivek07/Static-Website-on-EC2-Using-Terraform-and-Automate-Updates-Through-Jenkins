# Deploy a Static Website on AWS EC2 Using Terraform & Jenkins

Automated CI/CD pipeline for hosting a static website on an EC2 instance using **Terraform**, **Apache**, and **Jenkins**.  
Whenever code is pushed to GitHub, Jenkins automatically deploys the latest version to the EC2 instance.

---

## 📘 Project Overview

This project demonstrates how to:

- Provision an **AWS EC2 instance** using Terraform
- Install and configure **Apache** automatically via User Data
- Host a **static website** on EC2
- Automate deployments using **Jenkins CI/CD**
- Integrate **GitHub Webhooks** for automatic build triggers

---

## 🏗️ Architecture

![](/img/Gemini_Generated_Image_7ms56g7ms56g7ms5.png)


---

## ⚙️ Technologies Used

- **Terraform** – Infrastructure as Code
- **AWS EC2** – Hosting server
- **Ubuntu AMI**
- **Apache Web Server**
- **Jenkins** – CI/CD
- **Git & GitHub**
- **SSH Deployment**
- **Linux**

---

## 🚀 Terraform Deployment

Terraform provisions:

- EC2 instance
- Security Group (ports **22** & **80** open)
- Apache installation via User Data
- Clones GitHub repository into `/var/www/html`

**Example commands:**

```bash
terraform init
terraform apply -auto-approve
```

![](/img/Screenshot%20(965).png)

## EC2 User Data Script:

```
#!/bin/bash
apt update -y
apt install -y apache2 git
systemctl enable apache2
systemctl start apache2

rm -rf /var/www/html
mkdir -p /var/www/html

git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git /var/www/html

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
systemctl restart apache2
```
## 🔧 Jenkins CI/CD Pipeline
Pipeline Features

Triggered by GitHub webhook on code push

Pulls latest repository code

SSH into EC2

Clean old website code

Clone fresh code into /var/www/html

Restart Apache → website updates automatically

**Jenkinsfile Example:**

```
pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        EC2_USER = "ubuntu"
        TARGET = "YOUR_EC2_PUBLIC_IP"
    }

    stages {
        stage("Clone Repository") {
            steps {
                git url: "https://github.com/YOUR_USERNAME/YOUR_REPO.git", branch: "main"
            }
        }

        stage("Deploy to EC2") {
            steps {
                sshagent(credentials: ['ec2-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $EC2_USER@$TARGET 'sudo rm -rf /var/www/html'
                    ssh -o StrictHostKeyChecking=no $EC2_USER@$TARGET 'sudo mkdir -p /var/www/html'
                    ssh -o StrictHostKeyChecking=no $EC2_USER@$TARGET 'sudo git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git /var/www/html'
                    ssh -o StrictHostKeyChecking=no $EC2_USER@$TARGET 'sudo systemctl restart apache2'
                    """
                }
            }
        }
    }
}
```
![](/img/Screenshot%20(967).png)
![](/img/Screenshot%20(968).png)

**OUTPUT**
![](/img/3.png)

## 🌐 GitHub Webhook Setup

**Add Jenkins webhook URL in GitHub:**

- http://<JENKINS_PUBLIC_IP>:8080/github-webhook/


- Set events: Push events only

- Content type: application/json

## ✅ Conclusion

This project successfully demonstrates automated deployment of a static website on AWS EC2 using Terraform and Jenkins. The entire workflow is automated: infrastructure provisioning, Apache installation, website deployment, and updates are triggered automatically via GitHub webhooks.

Key takeaways:

Infrastructure as Code ensures repeatable and consistent deployments.

Jenkins CI/CD automates updates, reducing manual intervention.

Proper configuration of Apache and file permissions ensures the website renders correctly with CSS and assets.

Integrating GitHub, Jenkins, and AWS showcases a real-world DevOps workflow.

This project provides a solid foundation for learning cloud provisioning, CI/CD pipelines, and automated deployments in a professional DevOps environment.

## 👨‍💻 Author

**Vivek Ambadas Chopde**

- Cloud & DevOps Enthusiast
GitHub: https://github.com/chopadevivek07

- Email: chopadevivek07@gmail.com
