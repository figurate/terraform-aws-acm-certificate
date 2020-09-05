output "certificate_arn" {
  value       = module.certificate.certificate_arn
  description = "ARN of generated ACM certificate"
}
