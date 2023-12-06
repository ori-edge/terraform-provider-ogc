resource "ogc_deployment" "deployment" {
  package_id = ogc_package.package.id
  project_id = ogc_project.project.id
  environment_id = ogc_environment.environment.id
}
