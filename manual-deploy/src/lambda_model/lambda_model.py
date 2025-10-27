# lambda_model.py
import json



def heuristic_predict(features):
    # simple rules for rain prediction
    if features.get("precip_total", 0.0) > 1.0:
        return {"rain_tomorrow": True, "score": 0.9, "reason": "today_precip>1mm"}
    if features.get("humidity_max", 0) >= 90 and features.get("cloudcover_mean", 0) >= 60:
        return {"rain_tomorrow": True, "score": 0.75, "reason": "high_humidity_and_clouds"}
    if features.get("cloudcover_mean", 0) >= 80:
        return {"rain_tomorrow": True, "score": 0.6, "reason": "very_cloudy"}
    return {"rain_tomorrow": False, "score": 0.1, "reason": "no_indicators"}


def lambda_handler(event, context):
    # Handle both string and dict body
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
    features = data.get("features")

    if not features:
        return {"statusCode": 400, "body": {"error": "no_features"}}

    prediction = heuristic_predict(features)



    return {
        "statusCode": 200,
        "body": {
            "prediction": prediction,
            "features_used": features

        }
    }