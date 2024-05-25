terraform {
  backend "s3" {
    bucket = "cloudcentrics-bucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}