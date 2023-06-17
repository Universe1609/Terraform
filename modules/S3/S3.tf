resource "aws_s3_bucket" "bucket_s3" {
  bucket = var.bucket
}

resource "aws_s3_bucket_ownership_controls" "controls" {
  bucket = aws_s3_bucket.bucket_s3.id

  rule {
    object_ownership = var.control
  }
}

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [aws_s3_bucket_ownership_controls.controls]

  bucket = aws_s3_bucket.bucket_s3.id
  acl    = var.acl
}
