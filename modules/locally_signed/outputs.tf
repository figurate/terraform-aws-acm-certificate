output "certificate_arn" {
  value       = module.certificate.certificate_arn
  description = "ARN of generated ACM certificate"
}

output "ca_cert_pem" {
  value       = module.trust_anchor.cert_pem
  description = "CA signing certificate (PEM format)"
}
