# Terraform AWS S3 Static Website Configuration

# 

This Terraform configuration sets up an AWS S3 bucket for hosting a static website. It includes website configuration, ownership controls, public access block, ACL settings, and uploads files to the S3 bucket. It also uses a local version of S3 for testing purposes.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS CLI configured with necessary credentials
- LocalStack for testing purposes

## Usage

1. Clone the repository:
    
    ```bash
    git clone https://github.com/shefeekar/my-own-s3-try.git
    cd my-own-s3-try
    
    ```
    
2. Initialize the Terraform configuration:
    
    ```bash
    terraform init
    
    ```
    
3. Apply the Terraform configuration:
    
    ```bash
    terraform apply
    
    ```
    
4. Input required values as prompted.

## Configuration Details

- `main.tf`: Defines the AWS provider, S3 bucket, ownership controls, public access block, ACL settings, website configuration, and uploads files to the S3 bucket.
- `template_files`: Processes template files from the "web" directory.

## Local Development

For local development/testing, the configuration uses a local version of S3. Make sure to update the endpoints in the `provider "aws"` block accordingly.

```
provider "aws" {
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    s3 = "<http://s3.localhost.localstack.cloud:4566>"
  }
}
```

## **Cleanup**

To destroy the created resources:

```bash

terraform destroy

```

**Note:** Make sure to double-check and confirm before destroying resources.

##
