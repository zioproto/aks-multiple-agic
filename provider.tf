terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "< 4"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "local_file" "kubeconfig" {
  content  = module.aks.kube_config_raw
  filename = "${path.module}/kubeconfig"
}

provider "helm" {
  kubernetes {
    config_path = local_file.kubeconfig.filename
  }
}