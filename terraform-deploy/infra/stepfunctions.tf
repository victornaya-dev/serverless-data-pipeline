
resource "aws_sfn_state_machine" "pipeline" {
name = "StepFunction_MultipleMeteo"
role_arn = "arn:aws:iam::329177708113:role/service-role/StepFunctions-StepFunction_MultipleMeteo-role-jhkh1eml1"
region = "us-east-1"
definition = "{}" # placeholder temporal
lifecycle {
    ignore_changes = [
      definition
    ]
  }
}
