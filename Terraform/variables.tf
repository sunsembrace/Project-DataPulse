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

#Step 14. Variable function
variable "lambda_function_name" {
  type    = string
  default = "earthquakeFetcher"
}

#Step 21. Creating Cloudwatch EventBridge Rule variables.
variable "lambda_schedule_rule_name" {
  description = "Name of the CloudWatch EventBridge rule to trigger Lambda"
  type        = string
  default     = "datapulse_lambda_schedule_rule"
}

variable "lambda_schedule_expression" {
  description = "Schedule expression for the EventBridge rule (e.g., rate(1 hour))"
  type        = string
  default     = "rate(1 hour)"
}


#Step 22.
variable "lambda_permission_statement_id" {
  description = "Statement ID for the Lambda permission resource"
  type        = string
  default     = "AllowExecutionFromEventBridge"
}

variable "lambda_permission_principal" {
  description = "The AWS service principal allowed to invoke the Lambda function"
  type        = string
  default     = "events.amazonaws.com"
}


#Step 23. 
variable "lambda_event_target_id" {
  description = "Identifier for the EventBridge target"
  type        = string
  default     = "EarthquakeLambdaTarget"
}


#Step 26. S3 bucket name for Athena query'd results.
variable "athena_results_datapulse_eq_bucket" {
  description = "Bucket name for Athena query results"
  type        = string
}



#Step 27. Athena Database variables
variable "athena_datapulse_eq_database" {
  description = "Name of the Athena database"
  type        = string
}

#Step 28. Glue Catalog database. 
variable "glue_database_name" {
  description = "Name of the Glue Catalog database for structured table storage"
  type        = string
}

#Step 29. IAM Role for Glue crawler. 
variable "datapulse_glue_crawler_role" {
  description = "Name of the IAM role for the Glue Crawler"
  type        = string
  default     = "datapulse_glue_crawler_role"
}

#step 30. Policy ARN for Glue Crawler.check 
variable "glue_crawler_policy_arn" {
  description = "ARN of the policy to attach to Glue Crawler role (e.g. AWS managed policies)"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

#Step 31. Create Glue Crawler. 