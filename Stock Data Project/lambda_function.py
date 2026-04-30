import json
import urllib.request
import boto3
import pandas as pd
import io

s3 = boto3.client('s3')

def lambda_handler(event, context):

    # -----------------------------
    # 1. CONFIG
    # -----------------------------
    api_key = "API_KEY"
    symbol = "AAPL"

    bucket = "stock-pipeline-project"
    output_key = f"stock_processed/{symbol}.parquet"

    # -----------------------------
    # 2. FETCH API DATA
    # -----------------------------
    url = f"https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol={symbol}&apikey={api_key}"
    
    response = urllib.request.urlopen(url)
    data = json.loads(response.read())

    # -----------------------------
    # 3. VALIDATE API RESPONSE
    # -----------------------------
    if "Time Series (Daily)" not in data:
        raise Exception("Invalid API response or rate limit reached")

    time_series = data["Time Series (Daily)"]

    # -----------------------------
    # 4. TRANSFORM DATA
    # -----------------------------
    records = []

    for date, values in time_series.items():
        try:
            records.append({
                "date": date,
                "open": float(values["1. open"]),
                "high": float(values["2. high"]),
                "low": float(values["3. low"]),
                "close": float(values["4. close"]),
                "volume": int(values["5. volume"])
            })
        except Exception:
            continue

    df = pd.DataFrame(records)

    # -----------------------------
    # 5. SCHEMA VALIDATION
    # -----------------------------
    required_columns = {"date", "open", "high", "low", "close", "volume"}

    if not required_columns.issubset(df.columns):
        raise Exception(f"Missing required columns: {df.columns}")

    # -----------------------------
    # 6. DATA CLEANING
    # -----------------------------

    # remove nulls
    df = df.dropna()

    # convert date type
    df["date"] = pd.to_datetime(df["date"], format="%Y-%m-%d")

    # type enforcement
    df["open"] = df["open"].astype(float)
    df["high"] = df["high"].astype(float)
    df["low"] = df["low"].astype(float)
    df["close"] = df["close"].astype(float)
    df["volume"] = df["volume"].astype(int)

    # remove duplicates
    df = df.drop_duplicates(subset=["date"], keep="last")

    # sort data
    df = df.sort_values(by="date")

    # -----------------------------
    # 7. WRITE TO PARQUET
    # -----------------------------
    buffer = io.BytesIO()
    df.to_parquet(buffer, index=False)

    buffer.seek(0)

    s3.put_object(
        Bucket=bucket,
        Key=output_key,
        Body=buffer.getvalue()
    )

    print(f"Successfully saved: s3://{bucket}/{output_key}")
    print(df.head())

    return {
        "statusCode": 200,
        "body": "Stock ETL completed successfully"
    }
