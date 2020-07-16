# ![AWS](aws-logo.png) ACM Certificate

Purpose: Manage certificates in AWS.

Rationale: Apply standards and constraints to ACM certificates.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| certificate\_body | Body of the certificate | `any` | n/a | yes |
| certificate\_chain | Certificate chain for CA-signed certs | `any` | `null` | no |
| certificate\_name | Common name for certificate | `any` | n/a | yes |
| private\_key | Private key for the certificate | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| certificate\_arn | ARN of ACM certificate |

