resource "tls_self_signed_cert" "cert" {
  allowed_uses          = var.allowed_uses
  private_key_pem       = var.private_key_pem
  is_ca_certificate     = var.is_ca_certificate
  validity_period_hours = var.validity_period_hours
  subject {
    common_name  = var.common_name
    organization = var.organization
    country      = var.country
  }
}
