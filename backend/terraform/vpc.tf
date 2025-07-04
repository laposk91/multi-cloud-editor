# This data source gets a list of Availability Zones in the current region.
data "aws_availability_zones" "available" {}

# Using the official Terraform AWS module to create a robust VPC.
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "auditor-vpc"
  cidr = "10.0.0.0/16"

  # We want subnets in 2 different availability zones for high availability.
  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}