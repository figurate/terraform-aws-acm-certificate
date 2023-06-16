module "trust_anchor_key" {
  source = "../tls_private_key"
}

module "trust_anchor" {
  source = "../tls_self_signed_cert"
  allowed_uses = [
    "crl_signing",
    "client_auth",
    "server_auth",
    "cert_signing",
  ]
  private_key_pem       = module.trust_anchor_key.private_key_pem
  is_ca_certificate     = true
  validity_period_hours = 87600
  common_name  = var.ca_common_name
  organization = var.organization
  country      = var.country
}

module "issuer" {
  source = "../tls_private_key"
}

resource "tls_cert_request" "issuer" {
  private_key_pem = module.issuer.private_key_pem
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
  ca_cert_pem           = module.trust_anchor.cert_pem
  ca_private_key_pem    = module.trust_anchor_key.private_key_pem
  cert_request_pem      = tls_cert_request.issuer.cert_request_pem
  validity_period_hours = 8760
  is_ca_certificate     = true
}

module "certificate" {
  source = "../.."

  private_key       = module.issuer.private_key_pem
  certificate_body  = tls_locally_signed_cert.certificate.cert_request_pem
  certificate_chain = tls_locally_signed_cert.certificate.ca_cert_pem
  certificate_name  = var.common_name
}
