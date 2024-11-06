# Randoms

resource "random_string" "username" {
  length  = 20
  special = false
}