terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.33.0"
    }
  }
}

provider "aws" {
  access_key    = "AKIAQEARDRG4X7OFXVQC"
  secret_key                  = "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"
  region                      = "us-east-1"
 
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints{
      s3             = "http://s3.localhost.localstack.cloud:4566"
  }
}
#create s3 bucket 
resource "aws_s3_bucket" "s3_static_bucket" {
  bucket = "s3static321456"

  tags = {
    Name        = "s3 static bucket"
  }
}
resource "aws_s3_bucket_ownership_controls" "s3_static_bucket_ownership" {
  bucket = aws_s3_bucket.s3_static_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
    }
resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access" {
  bucket = aws_s3_bucket.s3_static_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.s3_static_bucket_ownership,
    aws_s3_bucket_public_access_block.s3_bucket_public_access,
  ]

  bucket = aws_s3_bucket.s3_static_bucket.id
  acl    = "public-read"
}
# Configure website configuration for the S3 bucket
resource "aws_s3_bucket_website_configuration" "s3_static_bucket_website_configuration" {
    bucket = aws_s3_bucket.s3_static_bucket.id

    index_document {
      suffix = "index.html"
    }
}
# Process template files from the "web" directory
module "template_files" {
    source = "hashicorp/dir/template"

    base_dir = "${path.module}/web"
}
# Upload files to the S3 bucket
resource "aws_s3_object" "s3_static_bucket_files" {
    bucket = aws_s3_bucket.s3_static_bucket.id

    for_each = module.template_files.files

    key          = each.key
    content_type = each.value.content_type

    source  = each.value.source_path
    content = each.value.content

    etag = each.value.digests.md5
}
