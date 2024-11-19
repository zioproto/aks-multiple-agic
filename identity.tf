resource "azurerm_role_assignment" "contributor" {
  scope                = azurerm_application_gateway.gateway.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

resource "azurerm_role_assignment" "contributor2" {
  scope                = azurerm_application_gateway.gateway2.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

resource "azurerm_role_assignment" "reader" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

data "azurerm_subscription" "current" {}

resource "azurerm_role_assignment" "contributor-noderg" {
  scope                = format("/subscriptions/%s/resourceGroups/%s", data.azurerm_subscription.current.subscription_id, module.aks.node_resource_group)
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

resource "azurerm_role_assignment" "network-contributor1" {
  scope                = format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Network/virtualNetworks/%s/subnets/%s", data.azurerm_subscription.current.subscription_id, azurerm_resource_group.this.name, "hub", "applicationGateway")
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

resource "azurerm_role_assignment" "network-contributor2" {
  scope                = format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Network/virtualNetworks/%s/subnets/%s", data.azurerm_subscription.current.subscription_id, azurerm_resource_group.this.name, "hub", "applicationGateway2")
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

resource "azurerm_user_assigned_identity" "this" {
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  name                = "agic-identity"
}

resource "azurerm_federated_identity_credential" "this" {
  name                = "agic-1"
  resource_group_name = azurerm_resource_group.this.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = module.aks.oidc_issuer_url
  subject             = "system:serviceaccount:default:ingress-azure-1"
  depends_on          = [module.aks]
  parent_id           = azurerm_user_assigned_identity.this.id
}

resource "azurerm_federated_identity_credential" "this2" {
  name                = "agic-2"
  resource_group_name = azurerm_resource_group.this.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = module.aks.oidc_issuer_url
  subject             = "system:serviceaccount:default:ingress-azure-2"
  depends_on          = [module.aks]
  parent_id           = azurerm_user_assigned_identity.this.id
}

