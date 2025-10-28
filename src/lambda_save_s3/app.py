# lambda_save_s3.py
import json
import boto3
import os

s3 = boto3.client("s3")
BUCKET_NAME = os.environ.get("BUCKET_NAME", "my-weather-results-102025")

def lambda_handler(event, context):
    # Parse input from previous Lambda
    body = event.get("body")
    if isinstance(body, str):
        try:
            data = json.loads(body)
        except json.JSONDecodeError:
            return {"statusCode": 400, "body": json.dumps({"error": "invalid_json_body"})}
    elif isinstance(body, dict):
        data = body
    else:
        data = event

    # Generate unique S3 key
    s3_key = f"results/result_{context.aws_request_id}.json"

    # Save data to S3
    try:
        s3.put_object(
            Bucket=BUCKET_NAME,
            Key=s3_key,
            Body=json.dumps(data),
            ContentType="application/json"
        )
    except Exception as e:
        return {"statusCode": 500, "body": json.dumps({"error": "s3_save_failed", "message": str(e)})}

    return {"statusCode": 200, "body": {"message": "saved_to_s3", "s3_key": s3_key}}