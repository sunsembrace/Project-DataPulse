# Step 1. AWS region
variable "aws_region" {
  description = "The AWS region to deploy into"
  type        = string
  default     = "eu-west-2" # London
}

# Step 2. S3 Bucket Name
variable "api_bucket_name" {
  description = "The name of the S3 bucket to store API data"
  type        = string
  default     = "datapulse-api-bucket" #Globally unique.
}

# Step 3. Lambda Role name
variable "lambda_role_name" {
  description = "IAM Role name for Lambda execution"
  type        = string
  default     = "lambda_exec_datapulse_role"
}