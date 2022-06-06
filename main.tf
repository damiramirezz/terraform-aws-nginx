provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "server_instance" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"
  tags = {
    Name = "InstanceFromTerraform"
  }
}