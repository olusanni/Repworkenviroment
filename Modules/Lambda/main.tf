data "archive_file" "python" {
  type        = "zip"
  source_file = "${path.root}/../../../applied/qa/python/lambda_function.py"
  output_path = "${path.root}/../../../applied/qa/python/lambda_function_fetchrole.zip"

}

resource "aws_lambda_function" "lambda_fetchrole" {
   function_name = var.Lambdafunction_name
   filename      = "${path.root}/../../../applied/qa/python/lambda_function_fetchrole.zip"
   handler       = "lambda_function.lambda_handler"
   role          = aws_iam_role.Fetch_role.arn

   source_code_hash = filebase64sha256(data.archive_file.python.output_path)

   runtime = "python3.12"

}
 
resource "aws_cloudwatch_event_rule" "role_cleanup" {
  name        = var.cloudwatch_rule
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "Lambda_target" {
  rule      = aws_cloudwatch_event_rule.role_cleanup.name
  target_id = "lambda"
  arn       = aws_lambda_function.lambda_fetchrole.arn
}


resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.Lambdafunction_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.role_cleanup.arn
}

resource "aws_iam_role" "Fetch_role" {
  name = var.iam_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid    = "",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "lambdarole_policy" {
  name   = "var.policy_name"
  role   = aws_iam_role.Fetch_role.id

   policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:GetRole",
          "iam:DeleteRole",
          "iam:ListRoles",
          "iam:ListRoleTags",
          "sns:Publish",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "config:PutConfigRule",
          "config:PutConfigRuleEvaluationResults",
          "config:DescribeConfigRules",
          "config:GetComplianceDetailsByConfigRule",
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "config:PutConfigurationRecorder",
          "config:PutDeliveryChannel",
          "config:DescribeConfigurationRecorders",
          "config:DescribeDeliveryChannels",
          "config:StartConfigurationRecorder",
          "config:StopConfigurationRecorder"
    
        ],
        Effect   = "Allow",
        Resource = ["*"]
      },
    ]
  })
}

