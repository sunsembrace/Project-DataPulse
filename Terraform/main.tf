#Step 1. Set up AWS provider region.
provider "aws" {
  region = var.aws_region
}

#Step 2. Create S3 bucket.
resource "aws_s3_bucket" "datapulse_api_bucket" {
  bucket = var.api_bucket_name

  tags = {
    Name        = "Datapulse API bucket"
  }
} 

#Step 3. Create IAM Role for Lambda Execution.
resource "aws_iam_role" "lambda_exec_role" {
  name = var.lambda_role_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
  }


#Step 4. Attach AWSLambdaBasicExecutionRole Policy. 
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#Step 5. Attach AmazonS3FullAccess Policy to Lambda Role
resource "aws_iam_role_policy_attachment" "lambda_s3_access" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
