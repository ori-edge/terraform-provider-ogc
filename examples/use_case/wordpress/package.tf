data ogc_project "default" {
  for_each = toset(["dev", "prod"])
  name = each.key
}

module "package" {
  for_each = toset(["dev", "prod"])
  source = "./package"
  env = each.key
}