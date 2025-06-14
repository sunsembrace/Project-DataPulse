# Step2. Output for S3 bucket name
output "s3_bucket_name" {
  description = "The name of the S3 bucket to store API data"
  value       = aws_s3_bucket.datapulse_api_bucket.bucket
}

# Step 3. Output for Lambda IAM Role ARN
output "lambda_role_arn" {
  description = "The ARN of the IAM role used by Lambda"
  value       = aws_iam_role.lambda_exec_role.arn
}
