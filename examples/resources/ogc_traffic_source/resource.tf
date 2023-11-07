resource "ogc_traffic_source" "ts" {
  display_name = "example"
  package_id = ogc_package.pkg.id
  address = "0.0.0.0/0"
}