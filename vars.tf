variable "private_key" {
  description = "Private key for the certificate"
}

variable "certificate_body" {
  description = "Body of the certificate"
}

variable "certificate_chain" {
  description = "Certificate chain for CA-signed certs"
  default     = null
}

variable "certificate_name" {
  description = "Common name for certificate"
}
