pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        TARGET = "54.169.209.197"
    }

    stages {
        stage("Clone Repository") {
            steps {
                git url: "https://github.com/chopadevivek07/Static-Website-on-EC2-Using-Terraform-and-Automate-Updates-Through-Jenkins.git", branch: "main"
            }
        }

        stage("Deploy to EC2") {
            steps {
                sshagent(credentials: ['ec2-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $TARGET 'sudo rm -rf /var/www/html/*'
                    ssh -o StrictHostKeyChecking=no $TARGET 'sudo git clone https://github.com/chopadevivek07/Static-Website-on-EC2-Using-Terraform-and-Automate-Updates-Through-Jenkins.git /var/www/html'
                    ssh -o StrictHostKeyChecking=no $TARGET 'sudo systemctl restart apache2'
                    """
                }
            }
        }
    }
}
