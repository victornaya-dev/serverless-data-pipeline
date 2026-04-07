variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
  default     = "MultipleMeteo-Pipeline"
}

variable "api_gateway_name" {
  description = "Name of the API Gateway HTTP API"
  type        = string
  default     = "api_tosend_data_lambda"
}

