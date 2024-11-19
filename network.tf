module "network" {
  source  = "Azure/subnets/azurerm"
  version = "1.0.0"

  resource_group_name = azurerm_resource_group.this.name
  subnets = {
    subnet0 = {
      address_prefixes = ["10.56.0.0/24"]
    }
    applicationGateway = {
      address_prefixes = ["10.56.1.0/24"]
    }
    applicationGateway2 = {
      address_prefixes = ["10.56.2.0/24"]
    }
  }
  virtual_network_address_space = ["10.56.0.0/16"]
  virtual_network_location      = var.region
  virtual_network_name          = "hub"
}