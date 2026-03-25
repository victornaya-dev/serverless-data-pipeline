  README.md (dev branch – Work in Progress)
### Serverless Data Pipeline (Work in Progress)

This repository is a **starter kit for a serverless, event-driven data pipeline** on AWS, using **Step Functions**, **Lambda**, **S3**, and **IAM**.  
It is currently under development in the `dev` branch. Changes are being tested and the final structure may evolve.

---

###  Current Status

- [x] Basic folder structure (`manual-deploy/`, `terraform-deploy/`)  
- [x] Lambda handlers for validation, transformation, and model  
- [x] Initial Terraform setup (`terraform-deploy/infra/`)  
- [ ] Complete deployment documentation  
- [ ] Integration with EventBridge and automatic triggers  
- [ ] Full pipeline testing in AWS  

---

###  Project Structure

```bash

serverless-data-pipeline/
├── src/                        
│   ├── lambda_validate/
│   │   └── app.py
│   ├── lambda_cleaning/
│   │   └── app.py
│   └── lambda_model/
│       └── app.py
│
├── manual-deploy/              # Manual deployment with AWS SAM
│   ├── infra/
│   │   └── template.yaml       # SAM / CloudFormation template
│   └── README.md               # SAM instructions (in progress)
│
├── terraform-deploy/
│   ├── infra/
│   │   ├── main.tf
│   │   ├── s3.tf
│   │   ├── lambda.tf
│   │   ├── iam.tf
│   │   ├── stepfunctions.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── README.md               # Terraform instructions (in progress)
│
└── README.md

```


###  Technologies Used

AWS Lambda — Serverless data processing functions

AWS Step Functions — Orchestration of Lambda workflows

Amazon S3 — Storage for raw and curated data

AWS IAM — Roles and security policies

AWS SAM — Manual deployment / learning CloudFormation

Terraform — Infrastructure as Code (IaC)

###  Important Notes

The dev branch is under development; it may contain frequent or incomplete changes.

For deployment or testing, it is recommended to use a development/test environment, not production.

README files in manual-deploy/ and terraform-deploy/ are in progress and will be completed soon.

###  License

MIT License — free for educational and professional use.

###  Author
Victor A. N.