# 🌧️ Rain Prediction — Deployment

Infrastructure as Code for the Rain Prediction project, provisioned on AWS via Terraform.

---

## Architecture

| Service | File | Role |
|---|---|---|
| S3 | `s3_frontend.tf` | Static frontend hosting |
| Lambda | `lambda.tf` | ML inference & data processing |
| Step Functions | `stepfunctions.tf` + `step_function_definition.json` | Pipeline orchestration |
| API Gateway | `api_gateway.tf` | HTTP endpoint exposure |
| IAM | `iam.tf` | Least-privilege roles & policies |
| CloudWatch | `cloudwatch_dashboard.tf` | Monitoring & alerting |

---

## Prerequisites

- Terraform `>= 1.3`
- AWS CLI configured with sufficient permissions

---

## Configuration

Define your values in a `terraform.tfvars` file (never commit this):

```hcl
aws_region       = "eu-west-1"
environment      = "prod"
project_name     = "rain-prediction"
lambda_image_uri = "123456789.dkr.ecr.eu-west-1.amazonaws.com/rain-prediction:latest"
```

See `variables.tf` for the full list of available variables.

---

## Deploy

```bash
cd terraform-deploy/infra

terraform init
terraform plan  -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

Retrieve outputs (API URL, bucket name, Lambda ARNs) at any time:

```bash
terraform output
```

## Destroy

```bash
terraform destroy -var-file="terraform.tfvars"
```

> ⚠️ This permanently deletes all provisioned resources.

---

## Notes

- The Step Functions definition (`step_function_definition.json`) uses `templatefile()` — ARNs are injected at apply time.
- Remote state (S3 + DynamoDB lock) is recommended for team use — configure in `main.tf`.
- Do not commit `terraform.tfvars`, `.terraform/`, or `*.tfstate` to version control.