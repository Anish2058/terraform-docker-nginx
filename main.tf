# main.tf

# 1. Tell Terraform which provider(s) we need
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# 2. Configure the Docker provider
provider "docker" {
    host = "npipe:////./pipe/docker_engine"
}

# 3. Define a resource: an Nginx container
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "web_server" {
  name  = "terraform-nginx-demo"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8060
  }
}