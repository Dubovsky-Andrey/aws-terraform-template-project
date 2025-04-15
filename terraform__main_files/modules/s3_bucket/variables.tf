variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "acl" {
  description = "Access control list (ACL) for the S3 bucket"
  type        = string
  default     = "private"
}

variable "versioning" {
  description = "Versioning configuration for the bucket"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "enable_encryption" {
  description = "Enable server-side encryption for the bucket"
  type        = bool
  default     = false
}

variable "encryption_algorithm" {
  description = "The server-side encryption algorithm to use (e.g., AES256 or aws:kms)"
  type        = string
  default     = "AES256"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g. stage, prod)"
  type        = string
}