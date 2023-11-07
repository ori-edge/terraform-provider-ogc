resource "ogc_project" "proj" {
  display_name = "tf-proj"
}

resource "ogc_project_registry" reg {
  name       = "tf-reg2"
  url        = "url.com"
  username   = "user"
  password   = "password"
  project_id = ogc_project.proj.id
}