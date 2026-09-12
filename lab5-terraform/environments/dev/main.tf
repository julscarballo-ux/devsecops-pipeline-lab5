terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
 
  backend "s3" {
    bucket         = "devsecops-lab-tfstate-2026"
    key            = "static-site/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

module "site" {
  source = "../../modules/static-site"

  bucket_name     = var.bucket_name
  index_file_path = "${path.module}/../../website/index.html"
  environment     = "dev"

  tags = {
    Equipo = "DevSecOps"
  }
}
