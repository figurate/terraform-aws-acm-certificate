run "create_cert" {
  command = plan

  module {
    source = "./modules/letsencrypt"
  }

  variables {
    common_name   = "Test Cert"
    email_address = "acme@example.com"
  }
}
