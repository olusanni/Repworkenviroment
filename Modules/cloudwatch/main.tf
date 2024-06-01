resource "aws_cloudwatch_event_rule" "role_cleanup" {
  name        = var.cloudwatch-rule
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
  function_name = aws_lambda_function.lambda_fetchrole.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.role_cleanup.arn
}