/*
Project: Marketing Customer Segmentation Analysis
Author: Abdikhani
Tool: Google BigQuery
Dataset: marketing
Goal: Analyze customer demographics, income, spending behavior, purchase patterns, and campaign response to uncover actionable business insights.
*/

-- =========================================================
-- 1. DATA INSPECTION
-- =========================================================

SELECT *
FROM `vibrant-outpost-381409.Markettig_data.marketting`;

-- Number of rows
SELECT COUNT(*) AS total_rows
FROM `vibrant-outpost-381409.Markettig_data.marketting`;

-- Number of columns
SELECT COUNT(*) AS total_columns
FROM `vibrant-outpost-381409.Markettig_data.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'marketting';

-- Column names and data types
SELECT column_name, data_type
FROM `vibrant-outpost-381409.Markettig_data.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'marketting';


-- =========================================================
-- 2. DATA QUALITY CHECKS
-- =========================================================

SELECT 
  COUNT(*) AS total_rows,
  COUNTIF(Year_Birth IS NULL) AS nulls_year_birth,
  COUNTIF(Education IS NULL) AS nulls_education,
  COUNTIF(Marital_Status IS NULL) AS nulls_marital_status,
  COUNTIF(_Income_ IS NULL) AS nulls_income,
  COUNTIF(Kidhome IS NULL) AS nulls_kidhome,
  COUNTIF(Teenhome IS NULL) AS nulls_teenhome,
  COUNTIF(Dt_Customer IS NULL) AS nulls_dt_customer,
  COUNTIF(Recency IS NULL) AS nulls_recency,
  COUNTIF(MntWines IS NULL) AS nulls_mnt_wines,
  COUNTIF(MntFruits IS NULL) AS nulls_mnt_fruits,
  COUNTIF(MntMeatProducts IS NULL) AS nulls_mnt_meat_products,
  COUNTIF(MntFishProducts IS NULL) AS nulls_mnt_fish_products,
  COUNTIF(MntSweetProducts IS NULL) AS nulls_mnt_sweet_products,
  COUNTIF(MntGoldProds IS NULL) AS nulls_mnt_gold_prods,
  COUNTIF(NumDealsPurchases IS NULL) AS nulls_num_deals_purchases,
  COUNTIF(NumWebPurchases IS NULL) AS nulls_num_web_purchases,
  COUNTIF(NumCatalogPurchases IS NULL) AS nulls_num_catalog_purchases,
  COUNTIF(NumStorePurchases IS NULL) AS nulls_num_store_purchases,
  COUNTIF(NumWebVisitsMonth IS NULL) AS nulls_num_web_visits_month,
  COUNTIF(Response IS NULL) AS nulls_response,
  COUNTIF(Complain IS NULL) AS nulls_complain,
  COUNTIF(AcceptedCmp1 IS NULL) AS nulls_accepted_cmp1,
  COUNTIF(AcceptedCmp2 IS NULL) AS nulls_accepted_cmp2,
  COUNTIF(AcceptedCmp3 IS NULL) AS nulls_accepted_cmp3,
  COUNTIF(AcceptedCmp4 IS NULL) AS nulls_accepted_cmp4,
  COUNTIF(AcceptedCmp5 IS NULL) AS nulls_accepted_cmp5
FROM `vibrant-outpost-381409.Markettig_data.marketting`;


-- =========================================================
-- 3. CUSTOMER SEGMENTATION BASE TABLE
-- =========================================================

WITH customer_base AS (
  SELECT
    *,
    EXTRACT(YEAR FROM CURRENT_DATE()) - Year_Birth AS Age,
    CONCAT(
      FLOOR((EXTRACT(YEAR FROM CURRENT_DATE()) - Year_Birth) / 10) * 10,
      '-',
      FLOOR((EXTRACT(YEAR FROM CURRENT_DATE()) - Year_Birth) / 10) * 10 + 9
    ) AS Age_Group,
    CONCAT(
      '$',
      FLOOR((_Income_ - 1) / 20000) * 20000 + 1,
      ' - $',
      FLOOR((_Income_ - 1) / 20000) * 20000 + 20000
    ) AS Income_Group
  FROM `vibrant-outpost-381409.Markettig_data.marketting`
)

-- =========================================================
-- 4. AGE GROUP VS PRODUCT SPENDING
-- =========================================================

SELECT
  Age_Group,
  SUM(MntWines) AS total_wine_spending,
  SUM(MntFruits) AS total_fruit_spending,
  SUM(MntMeatProducts) AS total_meat_spending,
  SUM(MntFishProducts) AS total_fish_spending,
  SUM(MntSweetProducts) AS total_sweet_spending,
  SUM(MntGoldProds) AS total_gold_spending
FROM customer_base
GROUP BY Age_Group
ORDER BY Age_Group;


-- =========================================================
-- 5. AGE GROUP VS INCOME & PURCHASE CHANNELS
-- =========================================================

WITH customer_base AS (
  SELECT
    *,
    EXTRACT(YEAR FROM CURRENT_DATE()) - Year_Birth AS Age,
    CONCAT(
      FLOOR((EXTRACT(YEAR FROM CURRENT_DATE()) - Year_Birth) / 10) * 10,
      '-',
      FLOOR((EXTRACT(YEAR FROM CURRENT_DATE()) - Year_Birth) / 10) * 10 + 9
    ) AS Age_Group
  FROM `vibrant-outpost-381409.Markettig_data.marketting`
)

SELECT
  Age_Group,
  SUM(_Income_) AS total_income,
  SUM(NumDealsPurchases) AS total_deals_purchases,
  SUM(NumWebPurchases) AS total_web_purchases,
  SUM(NumCatalogPurchases) AS total_catalog_purchases,
  SUM(NumStorePurchases) AS total_store_purchases
FROM customer_base
GROUP BY Age_Group
ORDER BY Age_Group;


-- =========================================================
-- 6. AGE GROUP VS CAMPAIGN RESPONSE & COMPLAINTS
-- =========================================================

WITH customer_base AS (
  SELECT
    *,
    CONCAT(
      FLOOR((EXTRACT(YEAR FROM CURRENT_DATE()) - Year_Birth) / 10) * 10,
      '-',
      FLOOR((EXTRACT(YEAR FROM CURRENT_DATE()) - Year_Birth) / 10) * 10 + 9
    ) AS Age_Group
  FROM `vibrant-outpost-381409.Markettig_data.marketting`
)

SELECT
  Age_Group,
  SUM(AcceptedCmp1) AS total_accepted_cmp1,
  SUM(AcceptedCmp2) AS total_accepted_cmp2,
  SUM(AcceptedCmp3) AS total_accepted_cmp3,
  SUM(AcceptedCmp4) AS total_accepted_cmp4,
  SUM(AcceptedCmp5) AS total_accepted_cmp5,
  SUM(Response) AS total_response,
  SUM(Complain) AS total_complain
FROM customer_base
GROUP BY Age_Group
ORDER BY Age_Group;


-- =========================================================
-- 7. INCOME GROUP VS SPENDING, PURCHASES & CAMPAIGNS
-- =========================================================

WITH customer_base AS (
  SELECT
    *,
    CONCAT(
      '$',
      FLOOR((_Income_ - 1) / 20000) * 20000 + 1,
      ' - $',
      FLOOR((_Income_ - 1) / 20000) * 20000 + 20000
    ) AS Income_Group
  FROM `vibrant-outpost-381409.Markettig_data.marketting`
  WHERE _Income_ IS NOT NULL
)

SELECT
  Income_Group,
  SUM(MntWines) AS total_mnt_wines,
  SUM(MntFruits) AS total_mnt_fruits,
  SUM(MntMeatProducts) AS total_mnt_meat_products,
  SUM(MntFishProducts) AS total_mnt_fish_products,
  SUM(MntSweetProducts) AS total_mnt_sweet_products,
  SUM(MntGoldProds) AS total_mnt_gold_prods,
  SUM(NumDealsPurchases) AS total_deals_purchases,
  SUM(NumWebPurchases) AS total_web_purchases,
  SUM(NumCatalogPurchases) AS total_catalog_purchases,
  SUM(NumStorePurchases) AS total_store_purchases,
  SUM(AcceptedCmp1) AS total_accepted_cmp1,
  SUM(AcceptedCmp2) AS total_accepted_cmp2,
  SUM(AcceptedCmp3) AS total_accepted_cmp3,
  SUM(AcceptedCmp4) AS total_accepted_cmp4,
  SUM(AcceptedCmp5) AS total_accepted_cmp5,
  SUM(Response) AS total_response,
  SUM(Complain) AS total_complain
FROM customer_base
GROUP BY Income_Group
ORDER BY Income_Group;


-- =========================================================
-- 8. MARITAL STATUS + INCOME GROUP ANALYSIS
-- =========================================================

WITH customer_base AS (
  SELECT
    *,
    CONCAT(
      '$',
      FLOOR((_Income_ - 1) / 20000) * 20000 + 1,
      ' - $',
      FLOOR((_Income_ - 1) / 20000) * 20000 + 20000
    ) AS Income_Group
  FROM `vibrant-outpost-381409.Markettig_data.marketting`
  WHERE _Income_ IS NOT NULL
)

SELECT
  Marital_Status,
  Income_Group,
  SUM(MntWines) AS total_mnt_wines,
  SUM(MntFruits) AS total_mnt_fruits,
  SUM(MntMeatProducts) AS total_mnt_meat_products,
  SUM(MntFishProducts) AS total_mnt_fish_products,
  SUM(MntSweetProducts) AS total_mnt_sweet_products,
  SUM(MntGoldProds) AS total_mnt_gold_prods,
  SUM(NumDealsPurchases) AS total_deals_purchases,
  SUM(NumWebPurchases) AS total_web_purchases,
  SUM(NumCatalogPurchases) AS total_catalog_purchases,
  SUM(NumStorePurchases) AS total_store_purchases,
  SUM(Response) AS total_response,
  SUM(Complain) AS total_complain
FROM customer_base
GROUP BY Marital_Status, Income_Group
ORDER BY Marital_Status, Income_Group;


-- =========================================================
-- 9. DEMOGRAPHIC SEGMENT ANALYSIS
-- =========================================================

WITH customer_base AS (
  SELECT
    *,
    CONCAT(
      FLOOR((EXTRACT(YEAR FROM CURRENT_DATE()) - Year_Birth) / 10) * 10,
      '-',
      FLOOR((EXTRACT(YEAR FROM CURRENT_DATE()) - Year_Birth) / 10) * 10 + 9
    ) AS Age_Group,
    CONCAT(
      '$',
      FLOOR((_Income_ - 1) / 20000) * 20000 + 1,
      ' - $',
      FLOOR((_Income_ - 1) / 20000) * 20000 + 20000
    ) AS Income_Group
  FROM `vibrant-outpost-381409.Markettig_data.marketting`
)

SELECT
  Age_Group,
  Income_Group,
  Marital_Status,
  Country,
  SUM(_Income_) AS total_income,
  SUM(MntWines) AS total_mnt_wines,
  SUM(MntFruits) AS total_mnt_fruits,
  SUM(MntMeatProducts) AS total_mnt_meat_products,
  SUM(MntFishProducts) AS total_mnt_fish_products,
  SUM(MntSweetProducts) AS total_mnt_sweet_products,
  SUM(MntGoldProds) AS total_mnt_gold_prods,
  SUM(NumDealsPurchases) AS total_deals_purchases,
  SUM(NumWebPurchases) AS total_web_purchases,
  SUM(NumCatalogPurchases) AS total_catalog_purchases,
  SUM(NumStorePurchases) AS total_store_purchases,
  SUM(AcceptedCmp1) AS total_accepted_cmp1,
  SUM(AcceptedCmp2) AS total_accepted_cmp2,
  SUM(AcceptedCmp3) AS total_accepted_cmp3,
  SUM(AcceptedCmp4) AS total_accepted_cmp4,
  SUM(AcceptedCmp5) AS total_accepted_cmp5,
  SUM(Response) AS total_response,
  SUM(Complain) AS total_complain
FROM customer_base
GROUP BY Age_Group, Income_Group, Marital_Status, Country
ORDER BY Age_Group, Income_Group, Marital_Status, Country;
