---
page_title: "Onboarding an AWS cluster"
---

EKS is the managed kubernetes offering from AWS. In this example we use a popular terraform module 
to create an EKS cluster using Terraform and then onboard it onto OGC.

```terraform
terraform {
  required_providers {
    ogc = {
      version = "0.1.0"
      source  = "ori-edge/ogc"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "ogc" {}

provider aws {
  region = "eu-west-2"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "tf-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-2a", "eu-west-2b"]
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
  public_subnets  = ["10.0.64.0/19", "10.0.96.0/19"]

  enable_nat_gateway = true
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                   = "tf-cluster"
  cluster_version                = "1.28"
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 1

      instance_types = ["t2.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}

resource "ogc_cluster" "cluster" {
  display_name                 = "tf-eks-cluster"
  permit_privileged_containers = false
  description                  = "cluster created by terraform"
  labels                       = {
    key = "value"
  }

  kubernetes_config {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}
```