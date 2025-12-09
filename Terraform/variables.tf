variable "aws_region" {
  default = "ap-southeast-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-00d8fc944fb171e29"
}

variable "key_name" {
  default = "first"
}

variable "repo_url" {
  default = "https://github.com/chopadevivek07/Static-Website-on-EC2-Using-Terraform-and-Automate-Updates-Through-Jenkins.git"
}
