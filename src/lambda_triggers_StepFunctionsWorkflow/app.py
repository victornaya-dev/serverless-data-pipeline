import json
import boto3
import os

# Step Functions client
sfn_client = boto3.client("stepfunctions")

STEP_FUNCTION_ARN = "arn:aws:states:***REMOVED***:***REMOVED***:stateMachine:StepFunction_MultipleMeteo"

# STEP_FUNCTION_ARN = os.environ["STEP_FUNCTION_ARN"]

def lambda_handler(event, context):
    try:
        # Parse JSON body from API Gateway HTTP API
        body = json.loads(event.get("body", "{}"))
        lat = body.get("lat")
        lon = body.get("lon")

        if lat is None or lon is None:
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "Missing 'lat' or 'lon' in request body"})
            }

        # Construct payload for Step Function
        payload = {
            "lat": lat,
            "lon": lon
        }

        # Start SYNCHRONOUS Step Function execution (waits for result)
        response = sfn_client.start_sync_execution(
            stateMachineArn=STEP_FUNCTION_ARN,
            input=json.dumps(payload)
        )

        # Check if execution succeeded
        status = response["status"]

        if status == "SUCCEEDED":
            return {
                "statusCode": 200,
                "body": response["output"]  # already a JSON string, return directly
            }
        else:
            # FAILED or TIMED_OUT
            error = response.get("error", "Unknown error")
            cause = response.get("cause", "No cause provided")
            return {
                "statusCode": 500,
                "body": json.dumps({
                    "error": error,
                    "cause": cause,
                    "status": status
                })
            }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }