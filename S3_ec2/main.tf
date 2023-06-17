terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

# variable for bucket name 

variable "bucket_name" {
  type = string
  default = "my-terraform-bucket-1234567890"
}

# variable for instance name

variable "instance_name" {
  type = string
  default = "ExampleAppServerInstance"
}

# variable for policy name

variable "policy_name" {
  type = string
  default = "my-terraform-policy"
}

# variable for role name

variable "role_name" {
  type = string
  default = "my-terraform-role"
}


# policy for s3 bucket access

resource "aws_iam_policy" "s3_bucket_policy" {
  name = var.policy_name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1234567890",
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${var.bucket_name}",
        "arn:aws:s3:::${var.bucket_name}/*"
      ]
    }
  ]
}

EOF
}

# role for s3 bucket access

resource "aws_iam_role" "s3_bucket_role" {
  name = var.role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1234567890",
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}

EOF
}

# attach policy to role

resource "aws_iam_role_policy_attachment" "s3_bucket_role_policy_attachment" {
  role = aws_iam_role.s3_bucket_role.name
  policy_arn = aws_iam_policy.s3_bucket_policy.arn
}

# instance with role attached

resource "aws_instance" "app_server" {
  ami           = "ami-0dc2d3e4c0f9ebd18"
  instance_type = "t2.micro"


  tags = {
    Name = var.instance_name
  }

 
}

# s3 bucket

resource "aws_s3_bucket" "my_terraform_bucket" {
  bucket = var.bucket_name
  acl    = "private"
  tags = {
    Name = var.bucket_name
  }
}

# output for bucket name

output "bucket_name" {
  value = aws_s3_bucket.my_terraform_bucket.id
}

# output for instance name

output "instance_name" {
  value = aws_instance.app_server.id
}

# output for policy name

output "policy_name" {
  value = aws_iam_policy.s3_bucket_policy.id
}

# output for role name

output "role_name" {
  value = aws_iam_role.s3_bucket_role.id
}

# output for policy attachment

output "policy_attachment" {
  value = aws_iam_role_policy_attachment.s3_bucket_role_policy_attachment.id
}

# output for instance profile

output "instance_profile" {
  value = aws_iam_role.s3_bucket_role.name
}




