module "s3_bucket" {
  source       = "./modules/s3_bucket"
  bucket_name  = var.bucket_name
  project_name = var.project_name
  environment  = var.environment
  versioning = {
    enabled = var.versioning
  }
  enable_encryption    = var.enable_encryption
  encryption_algorithm = var.encryption_algorithm
}