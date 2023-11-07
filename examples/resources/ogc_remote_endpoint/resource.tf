resource "ogc_remote_endpoint" "re" {
  display_name = "example"
  package_id = ogc_package.pkg.id
  address = "0.0.0.0/0"
}