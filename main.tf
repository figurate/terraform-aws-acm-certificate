/**
 * # ![AWS](aws-logo.png) ACM Certificate
 *
 * [![CI](https://github.com/figurate/terraform-aws-acm-certificate/actions/workflows/main.yml/badge.svg)](https://github.com/figurate/terraform-aws-acm-certificate/actions/workflows/main.yml)
 *
 * Purpose: Manage certificates in AWS.
 *
 * Rationale: Apply standards and constraints to ACM certificates.
 */
resource "aws_acm_certificate" "certificate" {
  private_key       = var.private_key
  certificate_body  = var.certificate_body
  certificate_chain = var.certificate_chain
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = var.certificate_name
  }
}
