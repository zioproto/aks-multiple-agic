# Create a Public IP with Terraform as:
# az network public-ip create -n myPublicIp -g myResourceGroup --allocation-method Static --sku Standard

resource "azurerm_public_ip" "publicip" {
  name                = "myPublicIp"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create an Application Gateway with Terraform as:
# az network application-gateway create -n myApplicationGateway -l eastus -g myResourceGroup --sku Standard_v2 --public-ip-address myPublicIp --vnet-name myVnet --subnet mySubnet --priority 100

resource "azurerm_application_gateway" "gateway" {
  name                = "myApplicationGateway"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "myApplicationGatewayIpConfig"
    subnet_id = lookup(module.network.vnet_subnets_name_id, "applicationGateway")
  }
  frontend_port {
    name = "feport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "feip"
    public_ip_address_id = azurerm_public_ip.publicip.id
  }
  http_listener {
    name                           = "httplistener"
    frontend_ip_configuration_name = "feip"
    frontend_port_name             = "feport"
    protocol                       = "Http"
  }

  backend_address_pool {
    name = "bepool"
  }

  backend_http_settings {
    name                  = "behttpsetting"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }


  request_routing_rule {
    name                       = "rule"
    rule_type                  = "Basic"
    http_listener_name         = "httplistener"
    backend_address_pool_name  = "bepool"
    backend_http_settings_name = "behttpsetting"
    priority                   = 20
  }
}



# Create a Public IP with Terraform as:
# az network public-ip create -n myPublicIp -g myResourceGroup --allocation-method Static --sku Standard

resource "azurerm_public_ip" "publicip2" {
  name                = "myPublicIp2"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create an Application Gateway with Terraform as:
# az network application-gateway create -n myApplicationGateway -l eastus -g myResourceGroup --sku Standard_v2 --public-ip-address myPublicIp --vnet-name myVnet --subnet mySubnet --priority 100

resource "azurerm_application_gateway" "gateway2" {
  name                = "myApplicationGateway2"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "myApplicationGatewayIpConfig"
    subnet_id = lookup(module.network.vnet_subnets_name_id, "applicationGateway2")
  }
  frontend_port {
    name = "feport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "feip"
    public_ip_address_id = azurerm_public_ip.publicip2.id
  }
  http_listener {
    name                           = "httplistener"
    frontend_ip_configuration_name = "feip"
    frontend_port_name             = "feport"
    protocol                       = "Http"
  }

  backend_address_pool {
    name = "bepool"
  }

  backend_http_settings {
    name                  = "behttpsetting"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }


  request_routing_rule {
    name                       = "rule"
    rule_type                  = "Basic"
    http_listener_name         = "httplistener"
    backend_address_pool_name  = "bepool"
    backend_http_settings_name = "behttpsetting"
    priority                   = 20
  }
}