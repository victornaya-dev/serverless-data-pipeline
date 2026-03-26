
resource "aws_sfn_state_machine" "pipeline" {
name = "StepFunction_MultipleMeteo"
role_arn = "arn:aws:iam::***REMOVED***:role/service-role/StepFunctions-StepFunction_MultipleMeteo-role-jhkh1eml1"
region = "***REMOVED***"
definition = "{}" # placeholder temporal
lifecycle {
    ignore_changes = [
      definition
    ]
  }
}
