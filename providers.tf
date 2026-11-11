terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Mumbai Region
provider "aws" {
  region = "ap-south-1"
}

# Sydney Region
provider "aws" {
  alias  = "sydney"
  region = "ap-southeast-2"
}
