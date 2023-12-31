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