terraform {

  cloud {
    organization = "SANBI"

    workspaces {
      name = "control-plane"
    }
  }

  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.50.0"
    }
    cloudns = {
      source = "mangadex-pub/cloudns"
      version = "0.2.0"
    }
  }
  
}

provider "cloudns" {
  auth_id = var.cloudns_api_user
  password = var.cloudns_api_password
  rate_limit = 5
}
