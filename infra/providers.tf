terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

    backend "s3" {
    bucket         = "tf-state-pulkit"         # S3 bucket name
    key            = "envs/test/terraform.tfstate" # Path within the bucket
    region         = "us-east-1"                  # Region for the bucket
    dynamodb_table = "terraform-locks"             # DynamoDB table for state locking
    encrypt        = true                          # Encrypt state at rest
  }
}

provider "aws" {
  region = var.region
}
