# 📊 Stock Data Analysis – SQL Queries (Amazon Athena)

This document contains all SQL queries used for analyzing the stock dataset stored in Amazon S3 using Amazon Athena.

---

## 🏗️ Table Creation

```sql
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
```

---

## 🔍 Data Preview

```sql
SELECT * FROM stock_data LIMIT 10;
```

---

# 📊 BUSINESS ANALYSIS QUERIES

---

## 1. Daily Price Trend

```sql
SELECT date, close
FROM stock_data
ORDER BY date;
```

---

## 2. Average Price (Business Value)

```sql
SELECT 
  AVG(close) AS avg_close_price,
  AVG(volume) AS avg_volume
FROM stock_data;
```

---

## 3. Highest Price Day

```sql
SELECT date, high
FROM stock_data
ORDER BY high DESC
LIMIT 1;
```

---

## 4. Lowest Price Day

```sql
SELECT date, low
FROM stock_data
ORDER BY low ASC
LIMIT 1;
```

---

## 5. Volatility (Risk Metric)

```sql
SELECT 
  AVG(high - low) AS avg_daily_volatility
FROM stock_data;
```

---

## 6. Summary Statistics

```sql
SELECT 
  MIN(close) AS min_price,
  MAX(close) AS max_price,
  AVG(close) AS avg_price
FROM stock_data;
```

---

## 7. Daily Price Change (Returns)

```sql
SELECT 
  date,
  close,
  close - LAG(close) OVER (ORDER BY date) AS price_change
FROM stock_data;
```

---

## 8. Top 5 Percentage Return Days

```sql
SELECT *
FROM (
  SELECT 
    date,
    close,
    ROUND(
      (close - LAG(close) OVER (ORDER BY date)) 
      / LAG(close) OVER (ORDER BY date) * 100, 2
    ) AS pct_return
  FROM stock_data
)
WHERE pct_return IS NOT NULL
ORDER BY pct_return DESC
LIMIT 5;
```

---

## 9. 7-Day Moving Average

```sql
SELECT 
  date,
  close,
  AVG(close) OVER (
    ORDER BY date 
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
  ) AS moving_avg_7d
FROM stock_data;
```

---

## 10. High Volatility Days

```sql
SELECT 
  date,
  (high - low) AS volatility
FROM stock_data
ORDER BY volatility DESC
LIMIT 5;
```

---

## 11. Volume Spike Detection

```sql
SELECT 
  date,
  volume
FROM stock_data
WHERE volume > (
  SELECT AVG(volume) FROM stock_data
)
ORDER BY volume DESC;
```

---

# 📌 Notes

* All queries are executed in Amazon Athena
* Data is stored in Parquet format in Amazon S3
* Window functions are used for trend and return analysis
