terraform {
  required_providers {
    shell = {
      source  = "scottwinkler/shell"
      version = "~> 1"
    }
  }
}
provider "google" {
  project = "example-gcp-project"
  region  = "us-east1"
}