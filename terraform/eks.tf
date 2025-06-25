module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4" # Use a specific, recent version

  cluster_name    = "auditor-cluster"
  cluster_version = "1.29" # Specify a recent Kubernetes version

  # Pass the VPC and subnet IDs from our VPC module.
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # This creates a managed group of EC2 instances (worker nodes) for our pods.
  eks_managed_node_groups = {
    general = {
      min_size     = 1
      max_size     = 3
      instance_types = ["t3.small"] # A good starting instance type
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}