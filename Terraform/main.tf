provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "sw_sg" {
  name = "sw_sg"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "static_website" {
  ami                    = var.ami_id
  key_name               = var.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sw_sg.id]

  user_data = <<-EOF
#!/bin/bash
apt update -y
apt install -y apache2 git
systemctl enable apache2
systemctl start apache2

rm -rf /var/www/html/*

git clone ${var.repo_url} /var/www/html/

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
systemctl restart apache2
EOF

  tags = {
    Name = "static_website"
  }
}
