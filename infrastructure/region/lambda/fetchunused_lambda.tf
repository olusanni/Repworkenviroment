module "Fetchunused_lambda" {
  source = "../../..//Modules/lambda"

 Lambdafunction_name = "fetchunused_iamrole"
 iam_role = "lambda_fetchUnused_role"
 policy_name = "Lambda_Fetch_Role_policy"
 region         = "us-east-2"


}


