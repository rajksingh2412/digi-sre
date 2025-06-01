# main.tf
provider "aws" {
  region = "us-east-1"  # change as needed
}

# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-state-raj"
#     key            = "ec2-authelia-stack/terraform.tfstate"
#     region         = "ap-south-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }


resource "aws_instance" "gitea_server" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI in us-east-1
  instance_type = "t2.micro"
  key_name      = "raj-key"  # replace with your actual key

  vpc_security_group_ids = [aws_security_group.gitea_sg.id]

  user_data = file("setup.sh")

  tags = {
    Name = "gitea-authelia-server"
  }
}

resource "aws_security_group" "gitea_sg" {
  name        = "gitea-authelia-sg"
  description = "Allow HTTP, HTTPS and SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
