# ----------------------------------------
# Lambda Validate
# ----------------------------------------

resource "aws_lambda_function" "lambda_validate" {
  function_name = "lambda_validate"
  handler       =  "lambda_function.lambda_handler"
  runtime = "python3.14"
  role =  "arn:aws:iam::329177708113:role/service-role/lambda_validate-role-12nyhroz"
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

# ----------------------------------------
# Lambda Model
# ----------------------------------------

resource "aws_lambda_function" "lambda_model"{
  function_name = "lambda_model"
  handler       =  "lambda_function.lambda_handler"
  runtime = "python3.14"
  role = "arn:aws:iam::329177708113:role/service-role/lambda_model-role-ty3ci0bb"
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

# ----------------------------------------
# Lambda cleaning
# ----------------------------------------
resource "aws_lambda_function" "lambda_cleaning" {
  function_name = "lambda_cleaning"
  role ="arn:aws:iam::329177708113:role/service-role/lambda_cleaning-role-a8bk6mlk"
  handler       =  "lambda_function.lambda_handler"
  runtime = "python3.14"
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

