module "iam_role_unused" {
  source = "../../..//Modules/config"

  config_rule = "iam-user-unused-credential-check"
  region = "us-east-2"
  max_credential_usage_age = "11"

}