terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40" 
    }
  }
  // Configure remote backend for state management
  backend "s3" {
    bucket         = "multi-cloud-editor" # MUST BE GLOBALLY UNIQUE
    key            = "multi-cloud-auditor/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_ecr_repository" "backend" {
  name                 = "multi-cloud-auditor/backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}