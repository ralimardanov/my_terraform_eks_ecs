provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

#AWS S3 for backend configuration
resource "aws_s3_bucket" "terraform_state" {
  bucket_prefix = var.bucket_prefix

  versioning {
    enabled = var.versioning_value
  }

  # use this in case if you don't want your bucket to be destroyed
  lifecycle {
    prevent_destroy = true
  }

  #turn on encryption on bucket
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.sse_algorithm
      }
    }
  }
}

#AWS DynamoDB table for backend configuration. Use this part in case if you want to use it.
/*
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = var.dynamodb_table_name
  read_capacity  = var.read_value
  write_capacity = var.write_value
  hash_key       = var.hash_key

  attribute {
    name = var.attribute_name
    type = var.attribute_type
  }
}
*/