module "eventrule_cloudwatch" {
  source = "../../..//Modules/cloudwatch"

 name        = "IAMRoleDelete"
  region = "us-east-2"
  schedule_expression = "cron(0 10 ? * 5L *)"

}