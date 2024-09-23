# Define the provider
provider "aws" {
  region = "us-east-2"
}

# Provision an EC2 instance
resource "aws_instance" "my_app" {
  ami           = "ami-0ebfd941bbafe70c6" 
  instance_type = "t2.micro"

  tags = {
    Name = "MyAppInstance"
  }
}

# Provision an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-for-my-app"
  acl    = "private"
}

# Provision a VPC (Virtual Private Cloud)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Create a security group for allowing SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
