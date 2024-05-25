module "s3_prod_bucket" {
  source = "../../..//Modules/s3"

  bucket_name = "newproject1-bucket2"
  region = "us-east-1" 

}