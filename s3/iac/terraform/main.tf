# 1. Project Requirements & Provider Declarations
terraform {
  required_version = ">= 1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 2. Configure the Active AWS Provider Endpoint
provider "aws" {
  region = "eu-north-1"
}

# 3. Input Variable Prompt (Triggers the interactive terminal break)
variable "custom_bucket_name" {
  type        = string
  description = "Enter a globally unique name for your new S3 bucket"

  # Standard AWS verification safety rule
  validation {
    condition     = can(regex("^[a-z0-9.-]+$", var.custom_bucket_name))
    error_message = "The bucket name must contain only lowercase letters, numbers, dots, or hyphens."
  }
}

# 4. Main S3 Storage Infrastructure Resource Definition
resource "aws_s3_bucket" "my_terraform_bucket" {
  # var.custom_bucket_name acts as a pointer to pull whatever you typed into the prompt
  bucket = var.custom_bucket_name
}
