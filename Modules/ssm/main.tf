resource "aws_ssm_parameter" "cleanup_parameters" {
  for_each = var.ssmparameters
  name     = "/iam-role-cleanup/${each.key}"
  type     = "String"
  value    = each.value
}