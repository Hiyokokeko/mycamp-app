# パブリックバケット
resource "aws_s3_bucket" "mycamp-s3-bucket" {
  bucket = "mycamp-s3-bucket-for-images"
  acl    = "public-read"

  tags = {
    Name = "mycamp-s3-bucket-for-images"
  }
}

# ログバケット
resource "aws_s3_bucket" "mycamp-alb-log" {
  bucket = "artifact-terraform-for-mycamp"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}
