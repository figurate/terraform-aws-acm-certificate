resource "tls_private_key" "ca_cert" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ca_cert" {
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  key_algorithm         = "RSA"
  private_key_pem       = tls_private_key.ca_cert.private_key_pem
  is_ca_certificate     = true
  validity_period_hours = 2160
  subject {
    common_name  = var.ca_common_name
    organization = var.organization
    country      = var.country
  }
}

resource "tls_cert_request" "certificate" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.ca_cert.private_key_pem
  subject {
    common_name  = var.common_name
    organization = var.organization
    country      = var.country
  }
}

resource "tls_locally_signed_cert" "certificate" {
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  ca_cert_pem           = tls_self_signed_cert.ca_cert.cert_pem
  ca_key_algorithm      = tls_self_signed_cert.ca_cert.key_algorithm
  ca_private_key_pem    = tls_private_key.ca_cert.private_key_pem
  cert_request_pem      = tls_cert_request.certificate.cert_request_pem
  validity_period_hours = 2160
}

module "certificate" {
  source = "../.."

  private_key       = tls_locally_signed_cert.certificate.ca_private_key_pem
  certificate_body  = tls_locally_signed_cert.certificate.cert_request_pem
  certificate_chain = tls_locally_signed_cert.certificate.ca_cert_pem
  certificate_name  = var.common_name
}
