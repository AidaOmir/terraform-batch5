provider aws {
    region = "us-east-2"

}


resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Security group for web instances"

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

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  count         = 3
  ami           = "ami-0900fe555666598a2"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.Bastion.key_name
  security_groups = [aws_security_group.web_sg.name]
user_data = file("user_data.sh")
user_data_replace_on_change = false

tags = local.common_tags
}



output "public_ips" {
  value = aws_instance.web.*.public_ip
}
