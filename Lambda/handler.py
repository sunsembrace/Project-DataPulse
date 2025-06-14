
import urllib.request
import json
import logging


logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"

    with urllib.request.urlopen(url) as response:
        data = json.loads(response.read())

    logger.info(f"Fetched {len(data['features'])} earthquakes")

    return {
        'statusCode': 200,
        'body': f"Feteched {len(data['features'])} earthquakes"
    }

