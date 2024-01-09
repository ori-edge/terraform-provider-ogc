resource "ogc_container" "container" {
  name = "example"
  application_id = ogc_application.app.id
  image = "nginx"
  env {
    name = "PORT"
    value = "80"
  }
}