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

#step 14. (Part 2 Terraform - returned after making lambda_handler.py)
#Lambda Function.check 
resource "aws_lambda_function" "earthquake_fetcher" {
  function_name = var.lambda_function_name
  filename      = "${path.module}/../lambda/lambda_function.zip"
  handler       = "lambda_handler.lambda_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_exec_role.arn
  source_code_hash = filebase64sha256("${path.module}/../lambda/lambda_function.zip")

  environment {
    variables = {
      S3_BUCKET = var.api_bucket_name
    }
  }

  tags = {
    Name = "Datapulse Earthquake Fetcher"
  }
}

#Step 21. Create Cloudwatch EventBridge.
resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name                = var.lambda_schedule_rule_name
  description         = "Triggers Lambda function on schedule"
  schedule_expression = var.lambda_schedule_expression
}

#Step 22.  Add Lambda Permission for EventBridge to Invoke
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = var.lambda_permission_statement_id
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.earthquake_fetcher.function_name
  principal     = var.lambda_permission_principal
  source_arn    = aws_cloudwatch_event_rule.lambda_schedule.arn #Calling on step 21 Lambda_schedule so need for block of code in variables.tf
}

#Step 23. Deploy and verify scheduled Lambda triggers.
resource "aws_cloudwatch_event_target" "trigger_lambda" {
  rule      = aws_cloudwatch_event_rule.lambda_schedule.name
  target_id = var.lambda_event_target_id
  arn       = aws_lambda_function.earthquake_fetcher.arn
}

#Phase 2 - Athena.
#Step 26. Create S3 bucket for Athena to store queried results into.
 resource "aws_s3_bucket" "athena_query_results" {
  bucket = var.athena_results_datapulse_eq_bucket

  tags = {
    Name        = "AthenaResults"
  }
}

#Step 27. Creating Athena Database. 
resource "aws_athena_database" "datapulse_eq_database" {
  name   = var.athena_datapulse_eq_database
  bucket = var.athena_results_datapulse_eq_bucket

  depends_on = [
    aws_s3_bucket.athena_query_results #Had to add this after for bug fixes due to DB creation relative to its bucket dependency. 
  ]
}


#Step 28. Create Glue Catalog Database. #Had to set up bc this is what Athena queries not the raw S3 files.  
resource "aws_glue_catalog_database" "datapulse_eq_glue_database" {
  name = var.glue_database_name
} 

#Step 29. Making IAM role for Glue Crawler.  #Can we modularise?
resource "aws_iam_role" "datapulse_glue_crawler_role" {
  name = var.datapulse_glue_crawler_role

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
          Service = "glue.amazonaws.com"
        }
      },
    ]
  })
  } 


#Step 30. Attach permissions to GlueCrawler Role. 
resource "aws_iam_role_policy_attachment" "glue_crawler_policy_attach" {
  role       = aws_iam_role.datapulse_glue_crawler_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole" 
} 

#Step 31. Create Glue Crawler. 
resource "aws_glue_crawler" "datapulse_eq_crawler" {
  name          = var.datapulse_glue_crawler_name
  role          = aws_iam_role.datapulse_glue_crawler_role.arn
  database_name = var.datapulse_glue_crawler_database_name
  description   = var.datapulse_glue_crawler_description

  s3_target {
    path = var.datapulse_glue_crawler_s3_target_path
  }

  schedule = var.datapulse_glue_crawler_schedule

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  tags = var.datapulse_glue_crawler_tags
}
