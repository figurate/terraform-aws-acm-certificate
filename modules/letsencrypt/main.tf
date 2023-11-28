/**
 * Provision a certificate using Let's Encrypt.
 */

module "ca_cert" {
  source = "../tls_private_key"
}

resource "acme_registration" "registration" {
  account_key_pem = module.ca_cert.private_key_pem
  email_address   = var.email_address
}

resource "acme_certificate" "certificate" {
  account_key_pem = acme_registration.registration.account_key_pem
  common_name     = var.common_name

  dns_challenge {
    provider = "route53"
  }
}

module "certificate" {
  source = "../.."

  private_key      = module.ca_cert.private_key_pem
  certificate_body = acme_certificate.certificate.certificate_pem
  certificate_name = var.common_name
}
