resource "aws_s3_bucket" "revo_s3_bucket" {
  bucket = var.bucket_name
}

  resource "aws_s3_bucket_versioning" "revo_s3_bucket" {
  bucket = aws_s3_bucket.revo_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
 resource "aws_s3_bucket_server_side_encryption_configuration" "revo_s3_bucket" {
  bucket = aws_s3_bucket.revo_s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}