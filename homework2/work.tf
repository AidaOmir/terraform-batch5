provider aws {
 region = "us-east-1"
}
resource "aws_key_pair" "deployer" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_s3_bucket" "kaizen_aida" {
  bucket = "kaizen-aida"
}

resource "aws_s3_bucket" "kaizen1" {
  bucket_prefix = "kaizenkaizen-"
}

  resource "aws_s3_bucket" "kaizen2" {
  bucket = "kaizenworld"
}


resource "aws_s3_bucket" "kaizen3" {
  bucket = "kaizenhello"
}

resource "aws_iam_user" "lb" {
    for_each = toset([
        "jenny",
        "rose",
        "lisa",
        "jisoo"
        ])
  name = each.key
}

resource "aws_iam_group" "hello" {
  name = "Blackpink"
}

resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
     for i in aws_iam_user.lb : i.name
  ]

  group = aws_iam_group.hello.name
}