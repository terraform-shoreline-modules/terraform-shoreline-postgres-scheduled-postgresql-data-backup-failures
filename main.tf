terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "scheduled_postgresql_data_backups_failing" {
  source    = "./modules/scheduled_postgresql_data_backups_failing"

  providers = {
    shoreline = shoreline
  }
}