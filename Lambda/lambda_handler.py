
import urllib.request
import json
import logging
import boto3
import os
from datetime import datetime

#Logger set up.
logger = logging.getLogger()
logger.setLevel(logging.INFO)

#AWS SDK set up.
s3 = boto3.client ('s3') 
S3_PREFIX = 'earthquake-data/'


def lambda_handler(event, context):
    S3_BUCKET = os.environ['S3_BUCKET'] #moved inside to catch missing env vars better.
    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"

    try: 
        with urllib.request.urlopen(url) as response:
            data = json.loads(response.read())

        logger.info(f"Fetched {len(data['features'])} earthquakes")

        timestamp = datetime.utcnow().strftime('%Y-%m-%dT%H-%M-%SZ')
        s3_key = f"{S3_PREFIX}earthquakes_{timestamp}.json"

        s3.put_object(
            Bucket = S3_BUCKET,
            Key = s3_key,
            Body = json.dumps(data),
            ContentType = 'application/json'
        )
        return {
            'statusCode': 200,
            'body': f"Fetched {len(data['features'])} earthquakes"
        }

    except Exception as e:
        logger.error(f"Error occurred: {e}")
        return {
            'statusCode': 500,
            'body': 'An error occurred during processing.'

        }
