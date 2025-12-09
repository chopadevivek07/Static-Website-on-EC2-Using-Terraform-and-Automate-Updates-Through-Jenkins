pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        EC2_USER = "ubuntu"
        TARGET = "54.169.209.197"
    }

    stages {

        stage("Clone Repository") {
            steps {
                git url: "https://github.com/chopadevivek07/Static-Website-on-EC2-Using-Terraform-and-Automate-Updates-Through-Jenkins.git",
                    branch: "main"
            }
        }

        stage("Deploy to EC2") {
            steps {
                sshagent(credentials: ['ec2-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $EC2_USER@$TARGET 'sudo rm -rf /var/www/html'
                    ssh -o StrictHostKeyChecking=no $EC2_USER@$TARGET 'sudo mkdir -p /var/www/html'
                    ssh -o StrictHostKeyChecking=no $EC2_USER@$TARGET 'sudo git clone https://github.com/chopadevivek07/Static-Website-on-EC2-Using-Terraform-and-Automate-Updates-Through-Jenkins.git /var/www/html'
                    ssh -o StrictHostKeyChecking=no $EC2_USER@$TARGET 'sudo systemctl restart apache2'
                    """
                }
            }
        }
    }
}
