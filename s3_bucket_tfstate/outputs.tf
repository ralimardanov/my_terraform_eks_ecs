output "s3_id" {
  value = aws_s3_bucket.terraform_state.id
}

/*
output "dynamodb_id" {
  value = aws_dynamodb_table.terraform_state_lock.id
}
*/