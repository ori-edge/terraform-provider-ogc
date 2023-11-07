resource "ogc_cluster" "kind" {
  display_name = "tf-kind-cluster"
  description = "cluster created by terraform"
  labels = {
    cloud = "local"
  }

  kubernetes_config {
    config_path = kind_cluster.default.kubeconfig_path
  }

  projects = [for o in values(data.ogc_project.default) : o.id ]
}



resource "kind_cluster" "default" {
  name = "test-cluster"
  wait_for_ready = true
}