# Specify the provider
provider "aws" {
  region = "ap-southeast-1"  # Change to your preferred AWS region
}

# Create a security group to allow SSH and HTTP access
resource "aws_security_group" "web_server_sg" {
  name_prefix = "web-server-sg"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Provision an EC2 instance
resource "aws_instance" "web_server" {
  ami                    = "ami-01811d4912b4ccb26"  # Amazon Linux 2 AMI for us>
  instance_type          = "t2.micro"
  key_name               = "assignmentkey"  # Replace with your key pair name
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "Hello, Terraform!" > /var/www/html/index.html
              EOF

  tags = {
    Name = "WebServer-Terraform"
  }
}

# Output the public IP address of the instance
output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}




