# ----------------------------------------
# HTTP API Gateway
# ----------------------------------------
resource "aws_apigatewayv2_api" "main" {
  name          = "api_tosend_data_lambda"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["https://rain-forecast-frontend.s3.us-east-1.amazonaws.com/index.html"]
    allow_methods = ["POST", "OPTIONS"]
    allow_headers = ["Content-Type"]
    max_age       = 300
  }

  lifecycle {
    ignore_changes = [name, protocol_type]  # keep protecting other fields, not cors
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

resource "aws_apigatewayv2_route" "post" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /predict"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_route" "options" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "OPTIONS /predict"
  # no target — API Gateway handles it automatically
}