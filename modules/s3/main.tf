resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket_name
  acl = var.bucket_privay
}