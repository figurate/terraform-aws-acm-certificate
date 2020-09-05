## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| acme | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| common\_name | Certificate common name | `any` | n/a | yes |
| email\_address | Email address associated with Letsencrypt certificate | `any` | n/a | yes |
| server\_url | URL of the Letsencrypt server | `string` | `"https://acme-staging-v02.api.letsencrypt.org/directory"` | no |

## Outputs

| Name | Description |
|------|-------------|
| certificate\_arn | ARN of generated ACM certificate |

