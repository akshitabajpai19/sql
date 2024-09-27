output "postgre_server_id" {
  value = azurerm_postgresql_flexible_server.posgresflexible.id
}

output "postgre_server_fqdn" {
  value = azurerm_postgresql_flexible_server.posgresflexible.fqdn
}