resource "ogc_container_mount" "mount" {
  container_id = ogc_container.container.id
  filepath = "/mnt"
  storage_request_id = ogc_storage_request.sr.id
}