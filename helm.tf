#helm install ingress-azure \
#  oci://mcr.microsoft.com/azure-application-gateway/charts/ingress-azure \
#  --set appgw.applicationGatewayID=$APPGW_ID \
#  --set armAuth.type=workloadIdentity \
#  --set armAuth.identityClientID=$IDENTITY_CLIENT_ID \
#  --set rbac.enabled=true \
#  --set kubernetes.ingressClassResource.name arbitrary-class \
#  --set kubernetes.ingressClassResource.controllerValue arbitrary-controller
#  --version 1.7.6

resource "helm_release" "ingress_azure_1" {
  name       = "ingress-azure-1"
  repository = "oci://mcr.microsoft.com/azure-application-gateway/charts"
  chart      = "ingress-azure"
  version    = "1.7.6"

  set {
    name  = "appgw.applicationGatewayID"
    value = azurerm_application_gateway.gateway.id
  }

  set {
    name  = "armAuth.type"
    value = "workloadIdentity"
  }

  set {
    name  = "armAuth.identityClientID"
    value = azurerm_user_assigned_identity.this.client_id
  }

  set {
    name  = "rbac.enabled"
    value = "true"
  }

  set {
    name  = "kubernetes.ingressClassResource.controllerValue"
    value = "azure/application-gateway-1"
  }

    set {
    name  = "kubernetes.ingressClassResource.name"
    value = "ingressgroup1"
  }

  depends_on = [azurerm_application_gateway.gateway, azurerm_federated_identity_credential.this]
}

resource "helm_release" "ingress_azure_2" {
  name       = "ingress-azure-2"
  repository = "oci://mcr.microsoft.com/azure-application-gateway/charts"
  chart      = "ingress-azure"
  version    = "1.7.6"

  set {
    name  = "appgw.applicationGatewayID"
    value = azurerm_application_gateway.gateway2.id
  }

  set {
    name  = "armAuth.type"
    value = "workloadIdentity"
  }

  set {
    name  = "armAuth.identityClientID"
    value = azurerm_user_assigned_identity.this.client_id
  }

  set {
    name  = "rbac.enabled"
    value = "true"
  }

  set {
    name  = "kubernetes.ingressClassResource.controllerValue"
    value = "azure/application-gateway-2"
  }

  set {
    name  = "kubernetes.ingressClassResource.name"
    value = "ingressgroup2"
  }

  depends_on = [azurerm_application_gateway.gateway, azurerm_federated_identity_credential.this]
}
