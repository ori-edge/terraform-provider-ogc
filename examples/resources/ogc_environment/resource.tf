resource "ogc_environment" env {
  display_name = "Test Environment"
  name = "test"
  description = "A description"
  project_id = ogc_project.project.id
}
