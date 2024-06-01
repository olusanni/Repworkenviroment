module "Fetch_iamrole" {
  source = "../../..//Modules/iamrole"

  iam_role = "lambda_fetchUnused_role"
  region = "us_east_2"
  policy_name = "Lambda_Fetch_Role_policy"
}
