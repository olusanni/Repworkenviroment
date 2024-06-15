module "ssm_parameters" {
  source = "../../..//Modules/ssm"
 
  region                       = "us-east-2"

  ssmparameters = {
    "notification-period-days" = "1"
    "unused-period-days"       = "11"
  }
}