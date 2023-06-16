resource "tls_private_key" "trust_anchor" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "trust_anchor" {
  allowed_uses = [
    "crl_signing",
    "client_auth",
    "server_auth",
    "cert_signing",
  ]
  private_key_pem       = tls_private_key.trust_anchor.private_key_pem
  is_ca_certificate     = true
  validity_period_hours = 87600
  subject {
    common_name  = var.ca_common_name
    organization = var.organization
    country      = var.country
  }
}

resource "tls_private_key" "issuer" {
  algorithm = "RSA"
}

resource "tls_cert_request" "issuer" {
  private_key_pem = tls_private_key.issuer.private_key_pem
  subject {
    common_name  = var.common_name
    organization = var.organization
    country      = var.country
  }
}

resource "tls_locally_signed_cert" "certificate" {
  allowed_uses = [
    "crl_signing",
    "cert_signing",
    "client_auth",
    "server_auth",
  ]
  ca_cert_pem           = tls_self_signed_cert.trust_anchor.cert_pem
  ca_private_key_pem    = tls_private_key.trust_anchor.private_key_pem
  cert_request_pem      = tls_cert_request.issuer.cert_request_pem
  validity_period_hours = 8760
  is_ca_certificate     = true
}

module "certificate" {
  source = "../.."

  private_key       = tls_private_key.issuer.private_key_pem
  certificate_body  = tls_locally_signed_cert.certificate.cert_request_pem
  certificate_chain = tls_locally_signed_cert.certificate.ca_cert_pem
  certificate_name  = var.common_name
}
