terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

variable "subnet_id" {
  type      = string
  description = "ID of the subnet from networking stack"
}

provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

data "aws_subnet" "selected" {
  id = var.subnet_id
}

data "aws_vpc" "selected" {
  id = data.aws_subnet.selected.vpc_id
}

resource "aws_security_group" "app" {
  name      = "orbit-labs-app-sg"
  description = "Security group for Orbit Labs app"
  vpc_id    = data.aws_vpc.selected.id

  tags = {
    name    = "Orbit Labs App SG"
    project = "Orbit-labs"
  }
}


output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "orbit_storage" {
  bucket_prefix = "orbit-storage-"

  tags = {
    name        = "Orbit Labs Storage"
    managedBy   = "Spacelift"
    mission     = "First Launch"
    project     = "Orbit-labs"
    environment = "demo"
  }
}
