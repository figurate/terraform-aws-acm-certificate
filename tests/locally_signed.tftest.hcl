run "create_cert" {
  command = plan

  module {
    source = "./modules/locally_signed"
  }

  variables {
    common_name    = "Test Cert"
    ca_common_name = "ACME PKI"
    organization   = "ACME"
    country        = "AU"
  }
}
