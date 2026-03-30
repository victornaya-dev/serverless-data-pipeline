# ----------------------------------------
# HTTP API Gateway
# ----------------------------------------
resource "aws_apigatewayv2_api" "main" {
  name          = "api_tosend_data_lambda"  
  protocol_type = "HTTP"

  lifecycle {
    ignore_changes = all
  }
}

# ----------------------------------------
# Stage
# ----------------------------------------
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "dev"
  auto_deploy = true

  lifecycle {
    ignore_changes = all
  }
}

# ----------------------------------------
# Integration (Lambda)
# ----------------------------------------
resource "aws_apigatewayv2_integration" "lambda" {
  api_id             = aws_apigatewayv2_api.main.id
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.lambda_triggers_StepFunctionsWorkflow.invoke_arn

  lifecycle {
    ignore_changes = all
  }
}

# ----------------------------------------
# Route
# ----------------------------------------
resource "aws_apigatewayv2_route" "main" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /predict"   

  lifecycle {
    ignore_changes = all
  }
}