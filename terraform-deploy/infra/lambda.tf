resource "aws_lambda_function" "lambda_validate" {
  function_name = "lambda_validate"
  handler       =  "lambda_function.lambda_handler"
  runtime = "python3.14"
  role =  "arn:aws:iam::***REMOVED***:role/service-role/lambda_validate-role-12nyhroz"
  timeout      = 3
  memory_size  = 128
  filename      = "ignore.zip"  # valor dummy

  # ignora cambios en filename/source_code_hash
  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash
    ]
  }
}