
resource "aws_sfn_state_machine" "pipeline" {
  name     = var.step_function_name
  role_arn = "arn:aws:iam::${var.account_id}:role/service-role/StepFunctions-${var.step_function_name}-role-wmtulcu93"
  type     = "EXPRESS"

  
definition = file("${path.module}/step_function_definition.json")
lifecycle {
    ignore_changes = [
      definition
    ]
  }
}

