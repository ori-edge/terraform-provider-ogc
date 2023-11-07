data "google_client_config" "default" {}

data google_project proj {
  project_id = "ori-edge"
}

variable region {
  default = "us-central1"
}

locals {
  ip_range_pods_name     = "${var.region}-01-gke-01-pods"
  ip_range_services_name = "${var.region}-01-gke-01-services"
}

module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  version      = "6.0.0"
  project_id   = data.google_project.proj.name
  network_name = "tf-network"

  subnets = [
    {
      subnet_name   = "tf-subnet"
      subnet_ip     = "10.10.0.0/16"
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    "tf-subnet" = [
      {
        range_name    = local.ip_range_pods_name
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = local.ip_range_services_name
        ip_cidr_range = "10.30.0.0/16"
      },
    ]
  }
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  version                    = "26.1.1"
  project_id                 = data.google_project.proj.name
  name                       = "gke-test-1"
  region                     = var.region
  network                    = module.gcp-network.network_name
  subnetwork                 = module.gcp-network.subnets_names[0]
  ip_range_pods              = local.ip_range_pods_name
  ip_range_services          = local.ip_range_services_name
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false

  node_pools = [
    {
      name           = "default-node-pool"
      machine_type   = "e2-medium"
      node_locations = "us-central1-b,us-central1-c"
      min_count      = 1
      max_count      = 1
      disk_size_gb   = 30
      disk_type      = "pd-standard"
      #      service_account           = "project-service-account@<PROJECT ID>.iam.gserviceaccount.com"
    },
  ]
}

resource "ogc_cluster" "gke" {
  display_name                 = "tf-gke-cluster"
  description                  = "cluster created by terraform"
  labels                       = {
    cloud = "gcp"
  }
  projects = [for o in values(data.ogc_project.default) : o.id ]

  kubernetes_config {
    host                   = "https://${module.gke.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  }
}