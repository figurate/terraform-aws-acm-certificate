run "create_cert" {
  command = plan

  module {
    source = "./modules/self_signed"
  }

  variables {
    common_name  = "Test Cert"
    organization = "ACME"
    country      = "AU"
  }
}
