resource "tls_private_key" "ca_cert" {
  algorithm = "RSA"
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.ca_cert.private_key_pem
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

  private_key      = tls_private_key.ca_cert.private_key_pem
  certificate_body = acme_certificate.certificate.certificate_pem
  certificate_name = var.common_name
}
