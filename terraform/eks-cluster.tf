module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.24"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = aws_vpc.custom_vpc.id
  subnet_ids               = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]

   eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t2.micro"]
    }
  }

  tags = {
    Environment = "dev"
    application   = "my-app"
  }
}