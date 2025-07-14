
1. 📘 DataPulse – Earthquake Data Processing & Analysis with AWS 🌍⚡️


2. 🧠 Description
DataPulse is a fully serverless, automated data pipeline designed to process and analyze real-time earthquake data. By transforming raw seismic events into structured insights, this solution supports proactive decision-making for risk mitigation, emergency preparedness, and operational continuity.


3. 🎯 Business Objective
Harnessing real-time earthquake data allows businesses to:

Anticipate and respond to natural disaster risks

Strengthen supply chain resilience

Protect assets and communities

Improve emergency protocols

Reduce downtime and disruption


4. 🛠️ Technical Overview
This solution uses Terraform for infrastructure provisioning and Python for compute logic, orchestrating several AWS services into a seamless, serverless data architecture:

🗃️ AWS S3: Central storage for raw earthquake data from the USGS API

🕵️ AWS Glue Crawler: Automatic schema detection and catalog updates

🔄 AWS Glue ETL Jobs: Cleanses, transforms, and enriches incoming data

⚡ AWS Athena: SQL-based, serverless querying for fast analytics

🐍 AWS Lambda: Fetches data from the API, formats it, and stores it in S3

⏰ AWS EventBridge: Triggers Lambda on a scheduled basis (e.g., hourly)

🔐 AWS IAM: Manages roles and enforces least privilege access

👀 AWS CloudWatch: Logs pipeline activity and enables alerting


4. 🚀 Getting Started
Prerequisites
AWS CLI & credentials

Terraform installed

Python 3.x

IAM permissions to provision resources

Setup Instructions
Clone the repo

Configure your .tfvars or environment files

Run Terraform to deploy infrastructure:

terraform init  
terraform plan  
terraform apply  
Deploy Lambda code and confirm scheduled triggers are active



5. 🧪 Usage
Once deployed, the pipeline will:

Call the USGS API on schedule (via Lambda)

Store timestamped GeoJSON earthquake data in S3

Trigger Glue Crawlers to catalog new data

Run ETL jobs to structure the dataset

Allow querying via AWS Athena

Example SQL query in Athena:

SELECT magnitude, location, time  
FROM earthquake_data  
WHERE magnitude > 5  
ORDER BY time DESC  


6. 🔧 Configuration
Ensure the following environment variables or .tfvars settings are configured:

LAMBDA_API_URL=https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson  
BUCKET_NAME=your-s3-bucket-name  
SCHEDULE_EXPRESSION=rate(1 hour)  


7. 💻 Tech Stack
AWS (Lambda, S3, Glue, Athena, IAM, CloudWatch, EventBridge)

Terraform

Python


8. USGS API → Lambda → S3 → Glue Crawler → Glue ETL → Athena  
            ↑            ↓        ↑  
         EventBridge   CloudWatch IAM  


9. 🐞 Known Limitations
Visualization layer (e.g., AWS QuickSight) is planned but not yet implemented

Currently uses hourly polling; real-time streaming not supported

Regional bias may exist in USGS data availability


10. ✍️ Future Improvements
Add QuickSight dashboards for visual insights

Integrate SNS or Slack alerts for high-magnitude events

Expand to other geospatial data sources (e.g., volcanoes, tsunamis)


12. 📄 License
This project is licensed under the [MIT License].


13. 🙏 Acknowledgements
USGS Earthquake GeoJSON API

AWS documentation and community guides


14. Challenges & Solutions
Understanding IAM Role vs Policy ARNs
Initially, I was confused why the IAM Role output only displayed a single ARN even though multiple policies were attached. I learned that the IAM Role itself has a unique ARN separate from the individual policy ARNs. This clarified how Terraform outputs work for IAM roles and helped me accurately reference resources in my infrastructure code.

Managing Resource Dependencies with Athena
During deployment, Athena queries sometimes failed because the underlying S3 bucket was not fully created beforehand. To fix this, I added an explicit depends_on attribute in Terraform to ensure the Athena database resource waits for the S3 bucket creation. This improved the reliability and order of my infrastructure provisioning.