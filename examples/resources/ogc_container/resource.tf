resource "ogc_container" "container" {
  name = "example"
  application_id = ogc_application.app.id
  image_name = "nginx"
  env {
    name = "PORT"
    value = "80"
  }
}