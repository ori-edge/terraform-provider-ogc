terraform {
  required_providers {
    ogc = {
      version = "0.0.1"
      source  = "hashicorp.com/dev/ogc"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "ogc" {}

provider "google" {
#  project     = "ori-edge"
#  region      = "us-central1"
#  zone        = "us-central1-c"
}