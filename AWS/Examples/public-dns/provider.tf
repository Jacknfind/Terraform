terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.50.0"
    }
  }
}
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
  profile="customprofile"
  access_key="***********"
  secret_key="***********"
}