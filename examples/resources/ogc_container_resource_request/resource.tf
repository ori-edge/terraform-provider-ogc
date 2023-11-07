resource "ogc_container_resource_request" "rr" {
  container_id = ogc_container.container.id
  resource_type = "memory"
  request = "1Gi"
  limit = "1Gi"
}