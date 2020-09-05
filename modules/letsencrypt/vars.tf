variable "common_name" {
  description = "Certificate common name"
}

variable "email_address" {
  description = "Email address associated with Letsencrypt certificate"
}

variable "server_url" {
  description = "URL of the Letsencrypt server"
  default     = "https://acme-staging-v02.api.letsencrypt.org/directory"
}
