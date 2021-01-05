variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "sse_algorithm" {
  description = "Encryption for S3 bucket"
  type        = string
  default     = "AES256"
}
variable "bucket_prefix" {
  description = "S3 bucket prefix"
  type        = string
  default     = ""
}
variable "versioning_value" {
  description = "True/False for versioning"
  type        = bool
  default     = false
}
variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = ""
}
variable "read_value" {
  description = "Read value for DB"
  type        = number
  default     = 1
}
variable "write_value" {
  description = "Write value for DB"
  type        = number
  default     = 1
}
variable "hash_key" {
  description = "Hash key for DB"
  type        = string
  default     = ""
}
variable "attribute_name" {
  description = "Attribute name for DB"
  type        = string
  default     = ""
}
variable "attribute_type" {
  description = "Attribute type for DB"
  type        = string
  default     = ""
}
