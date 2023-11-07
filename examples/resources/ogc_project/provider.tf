terraform {
  required_providers {
    ogc = {
      version = "0.0.1"
      source  = "hashicorp.com/dev/ogc"
    }
    kind = {
      source = "tehcyx/kind"
    }
  }
}

provider "ogc" {
}