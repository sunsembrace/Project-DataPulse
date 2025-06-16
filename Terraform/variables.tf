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
variable "athena_results_dp_eq_bucket" {
  description = "Bucket name for Athena query results"
  type        = string
}

variable "environment" {
  type        = string
  description = "Environment label (e.g., dev)" #Come back and edit this
}

#Step 27. Athena Database variables
variable "athena_dp_eq" {
  description = "Name of the Athena database"
  type        = string
}

variable "athena_results_dp_eq_bucket" {
  description = "S3 bucket for Athena query results"
  type        = string
}
