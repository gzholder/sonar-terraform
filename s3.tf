# Create S3 bucket
resource "aws_s3_bucket" "s3_test_buckets" {
  count  = length(var.s3_bucket_name)
  bucket = var.s3_bucket_name[count.index]
    tags = {
      Name = "S3-bucket-${count.index +1}"
  }
}

resource "aws_s3_bucket_public_access_block" "restrict_public_access" {
  count  = length(var.s3_bucket_name)
  bucket = aws_s3_bucket.s3_test_buckets[count.index].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
