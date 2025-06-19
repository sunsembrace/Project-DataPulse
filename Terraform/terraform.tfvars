
# Step 1. AWS region
aws_region     = "eu-west-2" # London

# Step 2. API Bucket for raw json.
api_bucket_name     = "datapulse-api-bucket" #Globally unique.

# Step 26.  Athena Bucket for query results.
athena_results_datapulse_eq_bucket = "datapulse-athena-results-bucket" #Globally unique.

# Step 27. Athena earth quake database.
athena_datapulse_eq_database = "datapulse_athena_db"


# Step 28.  Glue Crawler Database. 
glue_database_name = "datapulse_eq_glue_database"



# Step 31. Glue Crawler
datapulse_glue_crawler_s3_target_path = "s3://datapulse-api-bucket/" 
datapulse_glue_crawler_name           = "datapulse_eq_crawler"
datapulse_glue_crawler_description    = "Crawler to scan S3 data for Earthquake API JSON"
datapulse_glue_crawler_database_name  = "datapulse_eq_db"
datapulse_glue_crawler_schedule       = "cron(0 12 * * ? *)"
datapulse_glue_crawler_tags = {
  Project = "DataPulse"
  Env     = "Dev"
}
 