terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
  /*
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-bucket"
    dynamodb_table = "tfstate-lock-dynamodb"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    profile        = "devops-demo"
  }*/
}


provider "aws" {
  region = "eu-central-1"
  //profile = "devops-demo"
}


