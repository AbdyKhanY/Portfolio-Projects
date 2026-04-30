CREATE EXTERNAL TABLE IF NOT EXISTS stock_data (
    date TIMESTAMP,
    open DOUBLE,
    high DOUBLE,
    low DOUBLE,
    close DOUBLE,
    volume BIGINT
)
STORED AS PARQUET
LOCATION 's3://stock-pipeline-project/stock_processed';
