## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ca\_common\_name | Certificate Authority common name | `any` | n/a | yes |
| common\_name | Certificate common name | `any` | n/a | yes |
| country | Certificate country | `any` | n/a | yes |
| organization | Certificate organization | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ca\_cert\_pem | CA signing certificate (PEM format) |
| certificate\_arn | ARN of generated ACM certificate |

