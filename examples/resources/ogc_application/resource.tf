resource "ogc_package" "pkg" {
  name = "example"
  project_id = "0e145a36-1ee7-434c-9f30-9e1ba4da2d7c"
}

resource "ogc_application" "app" {
  name = "example"
  package_id = ogc_package.pkg.id
}