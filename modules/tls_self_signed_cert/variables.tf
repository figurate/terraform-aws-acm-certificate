variable "allowed_uses" {
  description = "List of allowable uses for the certificate"
  type = list(string)
}

variable "private_key_pem" {
  description = "Private key for certificate"
}

variable "is_ca_certificate" {
  description = "Indicates certificate is for CA"
  default = false
}

variable "validity_period_hours" {
  description = "Certificate validity period"
  type = number
}

variable "common_name" {
  description = "Certificate common name"
  default = null
}

variable "organization" {
  description = "Certificate organization"
}

variable "country" {
  description = "Certificate country"
}
