terraform {
    required_providers {
        aws= {
            source = "hashicorp/aws"
            version = "~> 4.0"
        
        }
    }
    backend "s3" {
        bucket          = "s3://multi-cloud-editor/multi-cloud-auditor/"
        key             = "multi-cloud-auditor/terraform.tfstate"
        region          = "us-east-lock"
        dynamodb_table  = "terraform-lock"
    }
}

provider "aws" {
    region ="us-east-1"
}

resource "aws_dynamodb_table" "terraform_lock"{
    name            ="terraform-lock"
    billing_mode    ="PAY_PER_REQUEST"
    hash_key        ="LockID"

    attribute {
        name = "LockID"
        type ="S"
    }
}

resource "aws_ecr_repository" "backend" {
    name                    ="multi-cloud-auditor"backend"
    image_tag_mutability    ="MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}