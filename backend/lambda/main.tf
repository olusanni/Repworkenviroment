data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/../applied/backend/python/lamda_function.py"
  output_path = "${path.module}/../applied/backend/python/lambda_function_fetchrole.zip"
#specifys the type of file(zip), the path where the python code is and where the zip file would be stored

resource "aws_lambda_function" "lambda_fetchrole" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "${path.module}/../applied/backend/python/lambda_function_fetchrole.zip"
  function_name = "fetchunused_iamrole"
  role          = aws_iam_role.Fetch_role.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "Python3.12"

}
}

resource "aws_cloudwatch_event_rule" "role_cleanup" {
  name        = "IAMRoleDelete"
  schedule_expression = "cron(0 10 ? * 5L *)"
  #runs 10am UTC+0 on the last thursday of each month
}

resource "aws_cloudwatch_event_target" "Lambda_target" {
  rule      = aws_cloudwatch_event_rule.role_cleanup.name
  target_id = "lambda"
  arn       = aws_lambda_function.lambda_fetchrole.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_fetchrole.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.role_cleanup.arn
}

resource "aws_ssm_parameter" "notification-period-days" {
  name  = "/iam-role-cleanup/notification-period-days"
  type  = "String"
  value = "1"
}
resource "aws_ssm_parameter" "unused-period-days" {
  name  = "/iam-role-cleanup/unused-period-days"
  type  = "String"
  value = "11"
}

resource "aws_sns_topic" "Fetch_delete" {
  name = "Fetch_deleteNotification"
}

resource "aws_sns_topic_subscription" "Subscribe_email" {
  topic_arn = aws_sns_topic.Fetch_delete.arn
  protocol  = "email"
  endpoint  = "sseun01@gmail.com"
}

resource "aws_config_config_rule" "iam_role_unused" {
  name = "iam-unused-role"

  source {
    owner             = "AWS"
    source_identifier = "IAM_ROLE_UNUSED"
  }
}
 input_parameters = jsonencode({
     maxRoleUsageAge = "11"
  })

  scope {
    compliance_resource_types = ["AWS::IAM::Role"]
  }
