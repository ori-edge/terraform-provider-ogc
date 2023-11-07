data ogc_project "default" {
  name = var.env
}

resource ogc_package "default" {
  name = "wordpress"
  project_id = data.ogc_project.default.id
}

resource ogc_application "fe" {
  name = "wordpress-fe"
  package_id = ogc_package.default.id
  replicas = var.env == "prod"? 3 : 1

  selector {
    key = "cloud"
    values = ["gcp"]
  }

  selector {
    key = "env"
    values = [var.env]
  }
}

resource ogc_container "fe" {
  name = "wordpress"
  image_name = "docker.io/wordpress"
  image_tag = "6.3-apache"
  application_id = ogc_application.fe.id

  env {
    name = "WORDPRESS_DB_PASSWORD"
    value = "mypassword"
  }

  env {
    name = "WORDPRESS_DB_HOST"
    value = "${ogc_application.db.name}.orinet.ori.cloud"
  }

  env {
    name = "WORDPRESS_DB_USER"
    value = "wordpress"
  }
}

resource ogc_traffic_source "internet" {
  display_name = "internet"
  package_id = ogc_package.default.id
  address = "0.0.0.0/0"
}

resource ogc_container_port "fe" {
  display_name = "http"
  container_id = ogc_container.fe.id
  internal = 80
  external = 80
}

resource ogc_route_policy "fe" {
  package_id = ogc_package.default.id
  port_id = ogc_container_port.fe.id
  traffic_source_id = ogc_traffic_source.internet.id
}

resource ogc_application "db" {
  name = "database"
  package_id = ogc_package.default.id
  replicas = var.env == "prod"? 3 : 1

  selector {
    key = "cloud"
    values = ["local"]
  }
}

resource ogc_container "db" {
  name = "database"
  image_name = "docker.io/mysql"
  image_tag = "8.0"
  application_id = ogc_application.db.id

  env {
    name = "MYSQL_ROOT_PASSWORD"
    value = "mypassword"
  }

  env {
    name = "MYSQL_DB_PASSWORD"
    value = "mypassword"
  }

  env {
    name = "MYSQL_DATABASE"
    value = "wordpress"
  }

  env {
    name = "MYSQL_USER"
    value = "wordpress"
  }
}

resource ogc_container_port "db" {
  display_name = "mysql"
  container_id = ogc_container.db.id
  internal = 3306
  external = 3306
}

resource ogc_route_policy "internal" {
  package_id = ogc_package.default.id
  port_id = ogc_container_port.db.id
  application_id = ogc_application.fe.id
}
