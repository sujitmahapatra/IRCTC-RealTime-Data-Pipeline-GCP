# config.py

PROJECT_ID = "gds-project-432013"  # Your GCP Project ID
TOPIC_ID = "irctc-data"  # Pub/Sub topic for data ingestion
SUBSCRIPTION_ID = "irctc-data-sub"  # Pub/Sub subscription for streaming
BQ_DATASET = "irctc_dwh"  # BigQuery dataset name
BQ_TABLE = "irctc_stream_tb"  # BigQuery table name
TEMP_LOCATION = "gs://your-bucket/temp"  # GCS bucket for Dataflow temp files
STAGING_LOCATION = "gs://your-bucket/staging"  # GCS bucket for Dataflow staging files
