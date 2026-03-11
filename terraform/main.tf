provider "aws" {
  region = var.region
}

# Security Group
resource "aws_security_group" "liberty_sg" {
  name        = "liberty-poc-sg"
  description = "Allow SSH and Liberty app traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9080
    to_port     = 9080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "liberty-poc-sg"
  }
}

# EC2 Instance
resource "aws_instance" "liberty_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.liberty_sg.id]

  tags = {
    Name = "liberty-poc-server"
  }
}