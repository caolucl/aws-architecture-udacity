provider "aws" {
  region = "us-east-1"
}

# Create 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "ec2-udacity-t2" {
  ami = "ami-078b2e48715e8766d"
  instance_type = "t2.micro"
  subnet_id = "subnet-9fa1f1f9"
  count = 4
  tags = {
    Name = "Udacity T2"
  }
}


# Create 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "ec2-udacity-m4" {
  ami = "ami-078b2e48715e8766d"
  instance_type = "m4.large"
  subnet_id = "subnet-9fa1f1f9"
  count = 2
  tags = {
    Name = "Udacity M4"
  }
}

