resource "ogc_storage_request" "sr" {
  display_name = "MongoDb"
  package_id = ogc_package.pkg.id
  persistence_type = "Persistent"
  type = "StandardHDD"
  capacity_requested_mb = "1024"
}