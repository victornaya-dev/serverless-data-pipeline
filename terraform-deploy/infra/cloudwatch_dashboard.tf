resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "MultipleMeteo-Pipeline"

  dashboard_body = jsonencode({
    widgets = [

      # -------------------------------------------------------
      # ROW 1 - API GATEWAY
      # -------------------------------------------------------
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 8
        height = 6
        properties = {
          title   = "API Gateway - Requests"
          view    = "timeSeries"
          region  = "***REMOVED***"
          /* metrics = [
            ["AWS/ApiGateway", "Count", "ApiId", local.api_gateway_id, { stat = "Sum", label = "Total requests" }]
          ]*/
          metrics = [
        ["AWS/ApiGateway", "Count", "ApiId", local.api_gateway_id, "Stage", "dev", { stat = "Sum", label = "Total requests" }]
        ]
          period = 300
        }
      },
      {
        type   = "metric"
        x      = 8
        y      = 0
        width  = 8
        height = 6
        properties = {
          title   = "API Gateway - Latency (ms)"
          view    = "timeSeries"
          region  = "***REMOVED***"
          metrics = [
            ["AWS/ApiGateway", "Latency",        "ApiId", local.api_gateway_id, { stat = "p50", label = "p50" }],
            ["AWS/ApiGateway", "Latency",        "ApiId", local.api_gateway_id, { stat = "p99", label = "p99" }],
            ["AWS/ApiGateway", "IntegrationLatency", "ApiId", local.api_gateway_id, { stat = "p50", label = "Integration p50" }]
          ]
          period = 300
        }
      },
      {
        type   = "metric"
        x      = 16
        y      = 0
        width  = 8
        height = 6
        properties = {
          title   = "API Gateway - 4xx / 5xx Errors"
          view    = "timeSeries"
          region  = "***REMOVED***"
          metrics = [
            ["AWS/ApiGateway", "4xx", "ApiId", local.api_gateway_id, { stat = "Sum", color = "#ff9900", label = "4xx" }],
            ["AWS/ApiGateway", "5xx", "ApiId", local.api_gateway_id, { stat = "Sum", color = "#d62728", label = "5xx" }]
          ]
          period = 300
        }
      },

      # -------------------------------------------------------
      # ROW 2 - LAMBDA TRIGGER
      # -------------------------------------------------------
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 8
        height = 6
        properties = {
          title   = "Lambda Trigger - Invocations & Errors"
          view    = "timeSeries"
          region  = "***REMOVED***"
          metrics = [
            ["AWS/Lambda", "Invocations", "FunctionName", "lambda_triggers_StepFunctionsWorkflow", { stat = "Sum", label = "Invocations" }],
            ["AWS/Lambda", "Errors",      "FunctionName", "lambda_triggers_StepFunctionsWorkflow", { stat = "Sum", color = "#d62728", label = "Errors" }]
          ]
          period = 300
        }
      },
      {
        type   = "metric"
        x      = 8
        y      = 6
        width  = 8
        height = 6
        properties = {
          title   = "Lambda Trigger - Duration (ms)"
          view    = "timeSeries"
          region  = "***REMOVED***"
          metrics = [
            ["AWS/Lambda", "Duration", "FunctionName", "lambda_triggers_StepFunctionsWorkflow", { stat = "Average", label = "Avg" }],
            ["AWS/Lambda", "Duration", "FunctionName", "lambda_triggers_StepFunctionsWorkflow", { stat = "Maximum", label = "Max" }]
          ]
          period = 300
        }
      },
      {
        type   = "metric"
        x      = 16
        y      = 6
        width  = 8
        height = 6
        properties = {
          title   = "Lambda Trigger - Throttles"
          view    = "timeSeries"
          region  = "***REMOVED***"
          metrics = [
            ["AWS/Lambda", "Throttles", "FunctionName", "lambda_triggers_StepFunctionsWorkflow", { stat = "Sum", color = "#ff9900", label = "Throttles" }]
          ]
          period = 300
        }
      },

      # -------------------------------------------------------
      # ROW 3 - STEP FUNCTIONS
      # -------------------------------------------------------
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 8
        height = 6
        properties = {
          title   = "Step Functions - Executions"
          view    = "timeSeries"
          region  = "***REMOVED***"
          metrics = [
            ["AWS/States", "ExecutionsStarted",   "StateMachineArn", "arn:aws:states:***REMOVED***:***REMOVED***:stateMachine:StepFunction_MultipleMeteo", { stat = "Sum", label = "Started" }],
            ["AWS/States", "ExecutionsSucceeded", "StateMachineArn", "arn:aws:states:***REMOVED***:***REMOVED***:stateMachine:StepFunction_MultipleMeteo", { stat = "Sum", color = "#2ca02c", label = "Succeeded" }],
            ["AWS/States", "ExecutionsFailed",    "StateMachineArn", "arn:aws:states:***REMOVED***:***REMOVED***:stateMachine:StepFunction_MultipleMeteo", { stat = "Sum", color = "#d62728", label = "Failed" }]
          ]
          period = 300
        }
      },
      {
        type   = "metric"
        x      = 8
        y      = 12
        width  = 8
        height = 6
        properties = {
          title   = "Step Functions - Execution Duration (ms)"
          view    = "timeSeries"
          region  = "***REMOVED***"
          metrics = [
            ["AWS/States", "ExecutionTime", "StateMachineArn", "arn:aws:states:***REMOVED***:***REMOVED***:stateMachine:StepFunction_MultipleMeteo", { stat = "Average", label = "Avg" }],
            ["AWS/States", "ExecutionTime", "StateMachineArn", "arn:aws:states:***REMOVED***:***REMOVED***:stateMachine:StepFunction_MultipleMeteo", { stat = "Maximum", label = "Max" }]
          ]
          period = 300
        }
      },
      {
        type   = "metric"
        x      = 16
        y      = 12
        width  = 8
        height = 6
        properties = {
          title   = "Step Functions - Throttled & Aborted"
          view    = "timeSeries"
          region  = "***REMOVED***"
          metrics = [
            ["AWS/States", "ExecutionThrottled", "StateMachineArn", "arn:aws:states:***REMOVED***:***REMOVED***:stateMachine:StepFunction_MultipleMeteo", { stat = "Sum", color = "#ff9900", label = "Throttled" }],
            ["AWS/States", "ExecutionsAborted",  "StateMachineArn", "arn:aws:states:***REMOVED***:***REMOVED***:stateMachine:StepFunction_MultipleMeteo", { stat = "Sum", color = "#9467bd", label = "Aborted" }]
          ]
          period = 300
        }
      },

      # -------------------------------------------------------
      # ROW 4 - LAMBDA PIPELINE (cleaning, validate, model)
      # -------------------------------------------------------
      {
        type   = "metric"
        x      = 0
        y      = 18
        width  = 8
        height = 6
        properties = {
          title   = "Lambda Cleaning - Invocations & Errors"
          view    = "timeSeries"
          region  = "***REMOVED***"
          metrics = [
            ["AWS/Lambda", "Invocations", "FunctionName", "lambda_cleaning", { stat = "Sum", label = "Invocations" }],
            ["AWS/Lambda", "Errors",      "FunctionName", "lambda_cleaning", { stat = "Sum", color = "#d62728", label = "Errors" }]
          ]
          period = 300
        }
      },
      {
        type   = "metric"
        x      = 8
        y      = 18
        width  = 8
        height = 6
        properties = {
          title   = "Lambda Validate - Invocations & Errors"
          view    = "timeSeries"
          region  = "***REMOVED***"
          metrics = [
            ["AWS/Lambda", "Invocations", "FunctionName", "lambda_validate", { stat = "Sum", label = "Invocations" }],
            ["AWS/Lambda", "Errors",      "FunctionName", "lambda_validate", { stat = "Sum", color = "#d62728", label = "Errors" }]
          ]
          period = 300
        }
      },
      {
        type   = "metric"
        x      = 16
        y      = 18
        width  = 8
        height = 6
        properties = {
          title   = "Lambda Model - Invocations & Errors"
          view    = "timeSeries"
          region  = "***REMOVED***"
          metrics = [
            ["AWS/Lambda", "Invocations", "FunctionName", "lambda_model", { stat = "Sum", label = "Invocations" }],
            ["AWS/Lambda", "Errors",      "FunctionName", "lambda_model", { stat = "Sum", color = "#d62728", label = "Errors" }]
          ]
          period = 300
        }
      }

    ]
  })
}
