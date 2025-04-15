variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Unique name for the S3 bucket"
  type        = string
}
variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g. stage, prod)"
  type        = string
}

variable "enable_encryption" {
  description = "Enable server-side encryption for the bucket"
  type        = bool
}

variable "encryption_algorithm" {
  description = "The server-side encryption algorithm to use (e.g., AES256 or aws:kms)"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable versioning for the bucket"
  type        = bool
}