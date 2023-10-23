# OGC Terraform Provider

Terraform provider to manage the lifecycle of OGC resources.

Documentation: [https://registry.terraform.io/providers/ori-edge/ogc/latest/docs](https://registry.terraform.io/providers/ori-edge/ogc/latest/docs?ref=ogc-tf-repo)

## Using the terraform provider

In order to use the OGC terraform provider, you first need to create an account in [OGC](https://console.ogc.ori.co/?ref=ogc-tf-repo) and generate an API token under your organisation settings.

Then, set the OGC_ACCESS_TOKEN environment var with your access token:

```bash
export OGC_ACCESS_TOKEN='api|xxxxxxxxxx'
```

You can then start interacting with OGC. For example, to onboard a local kind cluster, create a file `main.tf` with the content:

```terraform
terraform {
  required_providers {
    ogc = {
      source  = "ori-edge/ogc"
    }
    kind = {
      source = "tehcyx/kind"
    }
  }
}

provider "ogc" {
}

resource "ogc_cluster" "cluster" {
  display_name = "tf cluster"
  permit_privileged_containers = false
  description = "cluster created by terraform"
  labels = {
    key = "value"
  }

  kubernetes_config {
    config_path = kind_cluster.default.kubeconfig_path
  }
}


# Example local cluster (you can use GKE, EKS, AKS, etc instead)
provider "kind" {}

resource "kind_cluster" "default" {
  name = "test-cluster"
  wait_for_ready = true
}
```

And then run:

```bash
terraform init
terraform apply
```

When you're done you can run `terraform destroy` to clean up the resources.

You can see more examples in the official Terraform docs - [https://registry.terraform.io/providers/ori-edge/ogc/latest/docs](https://registry.terraform.io/providers/ori-edge/ogc/latest/docs?ref=ogc-tf-repo).