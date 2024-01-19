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
