data "azuread_application" "app" {
  display_name = "spn-acf-prod-pci-terraform-automation"
}

data "azuread_service_principal" "spn" {
  client_id = data.azuread_application.app.client_id
}