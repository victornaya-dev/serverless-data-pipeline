
resource "aws_sfn_state_machine" "pipeline" {
name = "StepFunction_MultipleMeteo"
role_arn = "arn:aws:iam::329177708113:role/service-role/StepFunctions-StepFunction_MultipleMeteo-role-wmtulcu93"
type     = "EXPRESS"

definition = file("${path.module}/step_function_definition.json")
lifecycle {
    ignore_changes = [
      definition
    ]
  }
}
