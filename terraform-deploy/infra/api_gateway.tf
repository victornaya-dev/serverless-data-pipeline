# ----------------------------------------
# HTTP API Gateway
# ----------------------------------------
resource "aws_apigatewayv2_api" "main" {
  name          = "api_tosend_data_lambda"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["POST", "OPTIONS"]
    allow_headers = ["Content-Type"]
    max_age       = 300
  }
}

# ----------------------------------------
# Stage
# ----------------------------------------
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "dev"
  auto_deploy = true
}

# ----------------------------------------
# Integration (Lambda)
# ----------------------------------------
resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.main.id
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  integration_uri        = aws_lambda_function.lambda_triggers_StepFunctionsWorkflow.invoke_arn
  payload_format_version = "2.0"
}

# ----------------------------------------
# Route
# ----------------------------------------
resource "aws_apigatewayv2_route" "post" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /predict"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}
