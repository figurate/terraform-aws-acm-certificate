resource "tls_private_key" "certificate" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "certificate" {
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  private_key_pem       = tls_private_key.certificate.private_key_pem
  validity_period_hours = 2160
  subject {
    common_name  = var.common_name
    organization = var.organization
    country      = var.country
  }
}

module "certificate" {
  source = "../.."

  private_key      = tls_private_key.certificate.private_key_pem
  certificate_body = tls_self_signed_cert.certificate.cert_pem
  certificate_name = var.common_name
}
