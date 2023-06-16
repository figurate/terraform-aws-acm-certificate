module "certificate_key" {
  source = "../tls_private_key"
}

module "self_signed_cert" {
  source = "../tls_self_signed_cert"
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  private_key_pem       = module.certificate_key.private_key_pem
  validity_period_hours = 2160
  common_name  = var.common_name
  organization = var.organization
  country      = var.country
}

module "certificate" {
  source = "../.."

  private_key      = module.certificate_key.private_key_pem
  certificate_body = module.self_signed_cert.cert_pem
  certificate_name = var.common_name
}
