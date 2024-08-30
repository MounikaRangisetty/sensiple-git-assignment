# Configure AWS Provider
provider "aws" {
  region = "us-east-1"  
}

# Create an EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-0e86e20dae9224db8"  
  instance_type = "t2.micro"

  # Install dependencies
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx"
    ]
  }

  # Tag the instance
  tags = {
    Name = "Terraform-Example"
  }
}
