# route policy between 2 applications
resource "ogc_route_policy" "internal" {
  package_id = ogc_package.pkg.id
  application_id = ogc_application.simple_app.id
  port_id = ogc_container_port.port.id
}

# expose an application to be accessible by the outside world
resource "ogc_route_policy" "external" {
  package_id = ogc_package.pkg.id
  traffic_source_id = ogc_traffic_source.internet.id
  port_id = ogc_container_port.port.id
}

# give internet access to an application
resource "ogc_route_policy" "internet" {
  package_id = ogc_package.pkg.id
  application_id = ogc_application.simple_app.id
  remote_endpoint_id = ogc_remote_endpoint.internet.id
}