terraform {
  required_providers {
    ogc = {
      version = "0.0.1"
      source  = "hashicorp.com/dev/ogc"
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
