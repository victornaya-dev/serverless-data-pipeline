resource "aws_iam_user" "serverles_project" {
  name = "serverles_project"
}

/*
# Policy 1
resource "aws_iam_policy" "stepfunction_policy" {
  name   = "Allow_ListStateMachineVersions"
  policy = file("policies/allow_stepfunctions.json")
}

# Policy 2
resource "aws_iam_policy" "lambda_policy" {
  name   = "AWSLambda_FullAccess"
  policy = file("policies/AWSLambda_FullAccess.json")
}

# Attach Policy 1
resource "aws_iam_user_policy_attachment" "attach_stepfunctions" {
  user       = aws_iam_user.serverles_project.name
  policy_arn = aws_iam_policy.stepfunctions_policy.arn
}

# Attach Policy 2
resource "aws_iam_user_policy_attachment" "attach_lambda" {
  user       = aws_iam_user.serverles_project.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
*/