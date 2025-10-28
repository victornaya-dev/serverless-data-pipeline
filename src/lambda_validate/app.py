# lambda_validate.py
import json
import os
import urllib.request
import urllib.parse
from datetime import datetime

def fetch_open_meteo(lat, lon):
    today = datetime.utcnow().date().isoformat()
    params = {
        "latitude": lat,
        "longitude": lon,
        "hourly": "temperature_2m,relativehumidity_2m,cloudcover,precipitation",
        "current_weather": "true",
        "timezone": "auto",
        "start_date": today,
        "end_date": today
    }
    url = "https://api.open-meteo.com/v1/forecast?" + urllib.parse.urlencode(params)
    with urllib.request.urlopen(url, timeout=10) as r:
        return json.load(r)

def validate_payload(payload):
    # check for current_weather and hourly weather keys
    if "current_weather" not in payload:
        return False, "Missing current_weather"
    if "hourly" not in payload:
        return False, "Missing hourly"
    hourly = payload["hourly"]
    required_hourly = ["temperature_2m", "relativehumidity_2m", "cloudcover", "precipitation"]
    for k in required_hourly:
        if k not in hourly:
            return False, f"Missing hourly.{k}"
    return True, ""

def lambda_handler(event, context):
    lat = event.get("lat", os.environ.get("DEFAULT_LAT", "48.8566"))   # default Paris
    lon = event.get("lon", os.environ.get("DEFAULT_LON", "2.3522"))
    
    try:
        raw_data = fetch_open_meteo(lat, lon)
    except Exception as e:
        return {"statusCode": 500, "body": {"error": "fetch_failed", "message": str(e)}}

    valid, msg = validate_payload(raw_data)
    if not valid:
        return {"statusCode": 400, "body": {"error": "validation_failed", "message": msg, "raw": raw_data}}

    # Return validated raw data — Step Functions will pass it to the next Lambda
    payload = {
        "lat": lat,
        "lon": lon,
        "raw": raw_data
    }

    return {"statusCode": 200, "body": payload}
