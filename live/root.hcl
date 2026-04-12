generate "provider" {
    path      = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents  = <<EOF
  terraform {
    required_providers {
      digitalocean = {
        source  = "digitalocean/digitalocean"
        version = "~> 2.0"
      }
      tls = {
        source  = "hashicorp/tls"
        version = "~> 4.0"
      }
      local = {
        source  = "hashicorp/local"
        version = "~> 2.0"
      }
      random = {
        source  = "hashicorp/random"
        version = "~> 3.0"
      }
    }
  }

  provider "digitalocean" {
    token = var.do_token
  }
  EOF
  }


inputs = {
  do_token = get_env("DIGITALOCEAN_TOKEN")
}
