resource "ogc_container_port" "port" {
  display_name = "http"
  container_id = ogc_container.container.id
  internal = 80
  external = 80
  protocol = "TCP"
}