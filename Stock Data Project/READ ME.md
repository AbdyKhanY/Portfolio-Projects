# 📊 Serverless Stock Data ETL Pipeline on AWS

## 📌 Project Overview

This project demonstrates a **serverless data engineering pipeline** built on AWS to ingest, process, and analyze stock market data using a public API.

The system automates the full ETL workflow:

**Stock API → AWS Lambda → Amazon S3 → AWS Glue/Athena → SQL Analytics**

It transforms raw financial data into structured Parquet format and enables business insights using SQL-based analytics.

---

## 🎯 Objective

To build a scalable, cloud-based ETL pipeline that:

* Automatically ingests stock market data from an API
* Cleans and transforms raw JSON data into structured format
* Stores optimized Parquet files in S3
* Enables analytical queries using Amazon Athena
* Extracts business insights for decision-making

---

## 🏗️ Architecture

1. Stock Market API (Alpha Vantage)
2. AWS Lambda (Data ingestion + transformation)
3. Amazon S3 (Raw + processed storage)
4. AWS Glue (Data cataloging - optional)
5. Amazon Athena (SQL analytics)

---

## ⚙️ ETL Workflow

### 1. Data Ingestion

* Stock data is fetched from Alpha Vantage API
* Lambda function triggers API call automatically

### 2. Data Processing

* JSON response is parsed into structured format
* Data cleaning includes:

  * Null handling
  * Deduplication
  * Schema validation
  * Type conversion

### 3. Data Storage

* Cleaned data is converted into **Parquet format**
* Stored in Amazon S3 for optimized querying

### 4. Data Analysis

* Amazon Athena is used to run SQL queries
* Data is analyzed for trends, volatility, and performance

---

## 📊 Business Insights & Analysis

The processed stock dataset was analyzed using SQL queries in Amazon Athena to extract meaningful financial insights and support data-driven decision-making.

---

### 🔹 Key Insights

* The stock maintained an average closing price of approximately **$264**, indicating a relatively stable trading range.

* The highest recorded price was **$288.62 (Dec 3, 2025)**, while the lowest was **$243.42 (Jan 20, 2026)**.

* The average daily volatility was approximately **5.24**, with a peak of **15.54 (Feb 12, 2026)**, indicating periods of increased risk.

* Volatility spikes were concentrated between **January and February 2026**, showing unstable trading conditions.

* The highest daily return was **+4.06% (Feb 2, 2026)**, with multiple strong gains in late January–February.

* The stock recorded an average trading volume of **~45 million shares**, indicating strong liquidity.

---

## 📸 Evidence (Query Outputs)

The following screenshots are included in the repository:

* Top percentage return days:
  ![top_returns](Images/top_returns.PNG)

* High volatility days:
  ![volatility](Images/volatility.PNG)

* Summary statistics (min, max, avg):
  
  ![summary_stats](Images/summary_stats.PNG)


---

## 📈 Business Recommendations

* Use the average price (~$264) as a benchmark for trading decisions
* Avoid trading during extreme volatility spikes unless risk-tolerant
* Focus on momentum periods (late Jan – Feb) for short-term opportunities
* Combine returns and volatility metrics for better decision-making
* Use high volume periods for efficient trade execution

---

## 🧰 Technologies Used

* AWS Lambda (Serverless compute)
* Amazon S3 (Data Lake storage)
* AWS Glue (Data catalog - optional)
* Amazon Athena (SQL analytics engine)
* Python (Data processing)
* Alpha Vantage API (Stock data source)

---

## 🚀 Key Features

* Fully serverless architecture
* Automated ETL pipeline
* Real-time stock data ingestion
* Optimized Parquet storage for analytics
* SQL-based business intelligence layer

---

## 📁 Project Structure

```
stock-etl-project/
│
├── lambda_function.py
├── sql/
├── README.md
├── images/
│   ├── top_returns.png
│   ├── volatility.png
│   ├── summary_stats.png
```

---

## 📌 What This Project Demonstrates

* Cloud ETL pipeline design
* Serverless architecture (AWS Lambda)
* Data engineering fundamentals
* SQL analytics using Athena
* Business intelligence from raw data

---

## 💡 Future Improvements

* Add real-time streaming (Kinesis)
* Automate scheduling with EventBridge
* Add dashboard (QuickSight / Power BI)
* Expand to multi-stock portfolio analysis

---


👉 write your **CV bullet points (interview-ready)**
👉 or polish your **GitHub repo title + description (SEO optimized)**
👉 or help you build **project #2 (even stronger than this one)**
