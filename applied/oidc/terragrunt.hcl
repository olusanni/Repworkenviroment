remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "362255407745-new-terraform-state-config" #"${get_aws_account_id()}-new-terraform-state-config"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "project-new-revolution-lock-config"
  }
}
