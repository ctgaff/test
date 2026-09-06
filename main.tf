provider "aws" {
  region = "us-east-1"
}

variable "environment" {
  default = "demo"
}

resource "aws_s3_bucket" "data" {
  bucket_prefix = "orbit-labs-"

  tags = {
    name        = "Orbit Labs Storage"
    managedBy   = "Spacelift"
    environment = var.environment
  }
}

output "bucket_name" {
  value = aws_s3_bucket.data.id
}
