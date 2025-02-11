import apache_beam as beam
from apache_beam.options.pipeline_options import PipelineOptions, StandardOptions
import json
import config

class TransformData(beam.DoFn):
    def process(self, element):
        try:
            record = json.loads(element.decode("utf-8"))
            record['name'] = record.get('name', '').title()  # Capitalize name
            record['email'] = record.get('email', '').lower()  # Convert email to lowercase
            record['loyalty_status'] = 'Platinum' if record.get('loyalty_points', 0) > 500 else 'Standard'
            yield record
        except Exception as e:
            print(f"Error processing record: {e}")

def run():
    pipeline_options = PipelineOptions(
        streaming=True,
        project=config.PROJECT_ID,
        temp_location=config.TEMP_LOCATION,
        staging_location=config.STAGING_LOCATION
    )
    pipeline_options.view_as(StandardOptions).streaming = True

    with beam.Pipeline(options=pipeline_options) as pipeline:
        (
            pipeline
            | "Read from Pub/Sub" >> beam.io.ReadFromPubSub(subscription=f"projects/{config.PROJECT_ID}/subscriptions/{config.SUBSCRIPTION_ID}")
            | "Transform Data" >> beam.ParDo(TransformData())
            | "Write to BigQuery" >> beam.io.WriteToBigQuery(
                table=f"{config.PROJECT_ID}:{config.BQ_DATASET}.{config.BQ_TABLE}",
                schema="row_key:STRING, name:STRING, age:INTEGER, email:STRING, join_date:DATE, last_login:TIMESTAMP, loyalty_points:INTEGER, account_balance:FLOAT, is_active:BOOLEAN, inserted_at:TIMESTAMP, updated_at:TIMESTAMP, loyalty_status:STRING, account_age_days:INTEGER",
                write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND
            )
        )

if __name__ == "__main__":
    run()
