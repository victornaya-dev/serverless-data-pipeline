# lambda_cleaning.py
import json

def compute_features(raw):
    hourly = raw["hourly"]
    temps = hourly["temperature_2m"]
    hums = hourly["relativehumidity_2m"]
    clouds = hourly["cloudcover"]
    prec = hourly["precipitation"]

    features = {
        "temp_mean": float(sum(temps) / len(temps)),
        "temp_max": float(max(temps)),
        "humidity_mean": float(sum(hums) / len(hums)),
        "humidity_max": float(max(hums)),
        "cloudcover_mean": float(sum(clouds) / len(clouds)),
        "precip_total": float(sum(prec)),
        "current_temp": float(
            raw.get("current_weather", {}).get("temperature", float(sum(temps) / len(temps)))
        )
    }
    return features


def lambda_handler(event, context):
    # Ensure raw data exists
    raw = event.get("raw") or (
    (json.loads(event["body"]).get("raw") if isinstance(event.get("body"), str) else event.get("body", {}).get("raw"))
    if event.get("body") else None)
    
    if not raw:
        return {"statusCode": 400, "body": {"error": "no_raw_data"}}

    # Compute features
    features = compute_features(raw)

    # Return results
    payload = {
        "lat": event.get("lat"),
        "lon": event.get("lon"),
        "features": features
    }

    # No Lambda chaining here — Step Functions will handle the workflow
    return {"statusCode": 200, "body": payload}

