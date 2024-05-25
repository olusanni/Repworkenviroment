module "s3bucket" {
  source = "../../..//Modules/s3"

  bucket_name = "newproject-bucket2"
  region = "us-east-1" 

}