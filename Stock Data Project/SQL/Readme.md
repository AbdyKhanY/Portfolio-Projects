# 📊 SQL Queries – Stock Data Analysis (Athena)

This folder contains all SQL queries used for analyzing the stock dataset in Amazon Athena.

The queries are used to transform raw stock data into meaningful business insights such as trends, volatility, returns, and trading activity.

---

## 📌 Purpose

The SQL scripts in this folder are designed to:

* Perform exploratory data analysis (EDA)
* Calculate financial metrics (returns, volatility, averages)
* Identify trends and anomalies in stock performance
* Support business decision-making through data insights

---

## 📁 Folder Structure

Each file represents a specific analysis task:

* `01_create_table.sql` → Creates Athena external table over S3 Parquet data
* `02_daily_trend.sql` → Tracks daily closing price movement
* `03_average_price.sql` → Calculates average price and volume
* `04_high_low.sql` → Finds highest and lowest trading days
* `05_volatility.sql` → Measures market volatility
* `06_summary_stats.sql` → Min, max, and average price summary
* `07_daily_returns.sql` → Daily price change calculation
* `08_top_returns.sql` → Top 5 percentage gain days
* `09_moving_average.sql` → 7-day moving average trend
* `10_volatility_days.sql` → Highest volatility days
* `11_volume_spikes.sql` → Detects unusual trading volume activity

---

## 🧠 Key Concepts Used

* SQL Aggregations (AVG, MIN, MAX)
* Window Functions (LAG, Moving Average)
* Subqueries
* Time-series analysis
* Financial metrics (returns, volatility, volume spikes)

---

## 📊 Business Value

These queries help to:

* Understand stock performance trends
* Measure risk using volatility
* Identify profitable trading periods
* Detect unusual market activity
* Support investment decision-making

---

## 🧾 Tools Used

* Amazon Athena (SQL engine)
* Amazon S3 (data storage)
* Parquet format (optimized analytics storage)

---

## 📌 Notes

* All queries assume data is stored in Parquet format in S3
* Table is created using external Athena table
* Queries are optimized for time-series financial analysis

---

If you want next step, I can help you:

👉 polish your **GitHub repo (full structure + final presentation)**
👉 or write your **CV experience section (this project → job-ready wording)**
