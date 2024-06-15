module "eventrule_cloudwatch" {
  source = "../../..//Modules/lambda"

 cloudwatch_rule       = "IAMRoleDelete"
  region = "us-east-2"
  schedule_expression = "cron(0 10 ? * 5L *)"
  lambdafunction_name  = "fetchunused_iamrole"

}
