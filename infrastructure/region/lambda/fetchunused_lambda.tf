module "Fetchunused_lambda" {
  source = "../../..//Modules/lambda"

 Lambdafunction_name = "fetchunused_iamrole"
 iam_role = "lambda_fetchUnused_role"
 policy_name = "Lambda_Fetch_Role_policy"
 cloudwatch_rule       = "IAMRoleDelete"
 schedule_expression = "rate(1 day)"
 region         = "us-east-2"

}
