resource "aws_config_config_rule" "iam_role_unused" {
  name = var.config_rule
    source {
    owner             = "AWS"
    source_identifier = "IAM_USER_UNUSED_CREDENTIALS_CHECK"
  }

 input_parameters = jsonencode({
    maxCredentialUsageAge = var.max_credential_usage_age
})
  scope {
    compliance_resource_types = ["AWS::IAM::Role"]
  }
}
