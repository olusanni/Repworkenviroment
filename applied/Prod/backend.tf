# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "362255407745-new-terraform-state-config"
    dynamodb_table = "project-new-revolution-lock-config"
    encrypt        = true
    key            = "./terraform.tfstate"
    region         = "us-east-1"
  }
}
