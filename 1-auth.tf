terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use latest version if possible
    }
  }

  backend "s3" {
    bucket  = "terraform-state-aaronmcd" # Name of the S3 bucket
    key     = "052525.tfstate"           # The name of the state file in the bucket
    region  = "us-east-2"                # Use a variable for the region
    encrypt = true                       # Enable server-side encryption (optional but recommended)
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "default"
}