# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "Project-Revolution"
    dynamodb_table = "Project-revolution-lock-table"
    encrypt        = true
    key            = "./terraform.tfstate"
    region         = "us-east-1"
  }
}
