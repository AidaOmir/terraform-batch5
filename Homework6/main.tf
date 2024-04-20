provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.example.id
  acl    = "private"
}


resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
  region        = var.region

  provisioner "remote-exec" {
    inline = [
      #!/bin/bash

"sudo apt update",
"sudo apt install apache2 -y",
"sudo systemctl start apache2",
"sudo systemctl enable apache2"
    ]
  }
}

