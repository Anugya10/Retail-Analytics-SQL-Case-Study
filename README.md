## 📌 Overview

This project focuses on analyzing a retail sales dataset using SQL to solve real-world business problems. The objective is to clean the data, perform exploratory data analysis (EDA), and generate actionable insights that support data-driven decision-making across sales, marketing, customer analytics, and inventory management.
The project demonstrates an end-to-end SQL analytics workflow, including data cleaning, data validation, customer segmentation, sales trend analysis, and customer behavior analysis using advanced SQL concepts such as Common Table Expressions (CTEs), Window Functions, Aggregate Functions, Conditional Logic, Joins, and Data Manipulation statements.

---

# 🎯 Business Problem

The retail company has observed stagnant business growth and declining customer engagement. Management wants to leverage transactional, customer, and inventory data to answer key business questions related to:

- Product Performance
- Customer Purchasing Behavior
- Customer Segmentation
- Sales Trends
- Customer Loyalty
- Inventory Optimization

The goal is to transform raw transactional data into meaningful business insights that can improve operational efficiency and strategic decision-making.

---

# 🎯 Project Objectives

- Clean and validate the raw dataset before analysis.
- Remove duplicate records and handle missing values.
- Standardize product pricing across datasets.
- Convert text-based dates into SQL DATE format.
- Analyze product performance.
- Understand customer purchasing behavior.
- Identify high-value and low-value customers.
- Measure monthly sales growth.
- Segment customers based on purchasing behavior.
- Generate actionable business recommendations.

---

# 🗂 Dataset

The project uses three relational tables.

## 1️⃣ Sales Transaction

Contains sales transaction details.

| Column |
|---------|
| TransactionID |
| CustomerID |
| ProductID |
| QuantityPurchased |
| Price |
| TransactionDate |

---

## 2️⃣ Customer Profiles

Contains customer demographic information.

| Column |
|---------|
| CustomerID |
| Age |
| Gender |
| Location |
| JoinDate |

---

## 3️⃣ Product Inventory

Contains product information.

| Column |
|---------|
| ProductID |
| ProductName |
| Category |
| StockLevel |
| Price |

---

# 📊 Business Questions Solved

---

# 1. Identify Duplicate Records

### 🎯 Business Objective

Identify duplicate transaction records to improve data quality before performing business analysis.

### 🛠 SQL Concepts Used

- **GROUP BY** – Groups records based on TransactionID.
- **COUNT()** – Counts duplicate occurrences.
- **HAVING** – Filters only duplicate records.
- **DISTINCT** – Removes duplicate rows.
- **CREATE TABLE** – Creates a cleaned table.
- **DROP TABLE** – Removes the original table.
- **ALTER TABLE** – Renames the cleaned table.

### 🔍 Business Finding

Duplicate records inflate sales, revenue, and transaction counts, leading to inaccurate reporting.

### 💡 Business Recommendation

Implement primary keys and automated validation rules to prevent duplicate transaction records.

---

# 2. Identify Product Price Discrepancies

### 🎯 Business Objective

Ensure product prices remain consistent across transaction and inventory tables.

### 🛠 SQL Concepts Used

- **INNER JOIN** – Matches products between both tables.
- **WHERE** – Filters records with inconsistent prices.
- **UPDATE** – Corrects incorrect prices.
- **SET** – Updates values with the correct inventory price.

### 🔍 Business Finding

Price inconsistencies produce inaccurate revenue calculations.

### 💡 Business Recommendation

Maintain a centralized pricing system and synchronize product prices regularly.

---

# 3. Replace Missing Values

### 🎯 Business Objective

Improve data completeness for customer analysis.

### 🛠 SQL Concepts Used

- **COUNT()** – Counts NULL values.
- **WHERE** – Filters missing records.
- **UPDATE** – Replaces missing values.
- **SET** – Assigns the value "Unknown".

### 🔍 Business Finding

Missing customer locations reduce the effectiveness of regional analysis.

### 💡 Business Recommendation

Introduce mandatory validation during customer registration.

---

# 4. Clean Transaction Date

### 🎯 Business Objective

Convert text-based dates into DATE format for accurate time-series analysis.

### 🛠 SQL Concepts Used

- **CAST()** – Converts TEXT into DATE.
- **CREATE TABLE** – Creates a new cleaned table.
- **DROP TABLE** – Removes the old table.
- **ALTER TABLE** – Renames the cleaned table.

### 🔍 Business Finding

Text-formatted dates prevent proper monthly and yearly analysis.

### 💡 Business Recommendation

Always store dates using SQL DATE or DATETIME data types.

---

# 5. Product-wise Sales Performance

### 🎯 Business Objective

Measure sales performance for every product.

### 🛠 SQL Concepts Used

- **SUM()** – Calculates total revenue and quantity sold.
- **GROUP BY** – Aggregates sales by product.
- **ORDER BY** – Ranks products by sales.

### 🔍 Business Finding

A small number of products generate a significant portion of total revenue.

### 💡 Business Recommendation

Increase inventory and marketing efforts for top-performing products.

---

# 6. Customer Purchase Frequency

### 🎯 Business Objective

Measure how frequently customers make purchases.

### 🛠 SQL Concepts Used

- **COUNT()** – Counts transactions.
- **GROUP BY** – Aggregates transactions by customer.
- **ORDER BY** – Ranks customers.

### 🔍 Business Finding

Customer purchase frequency varies considerably across the customer base.

### 💡 Business Recommendation

Develop loyalty programs to increase repeat purchases.

---

# 7. Product Category Performance

### 🎯 Business Objective

Evaluate sales performance across product categories.

### 🛠 SQL Concepts Used

- **INNER JOIN** – Combines sales and product information.
- **SUM()** – Calculates category revenue.
- **GROUP BY** – Groups by category.
- **ORDER BY** – Ranks categories.

### 🔍 Business Finding

Some categories contribute significantly more revenue than others.

### 💡 Business Recommendation

Allocate marketing budgets based on category performance.

---

# 8. Top 10 Revenue-Generating Products

### 🎯 Business Objective

Identify products contributing the highest revenue.

### 🛠 SQL Concepts Used

- **SUM()** – Calculates revenue.
- **GROUP BY** – Groups by product.
- **ORDER BY** – Sorts revenue descending.
- **LIMIT** – Returns top 10 products.

### 🔍 Business Finding

A few products account for the largest share of total revenue.

### 💡 Business Recommendation

Maintain adequate stock levels and prioritize these products in promotions.

---

# 9. Bottom 10 Products by Units Sold

### 🎯 Business Objective

Identify slow-moving inventory.

### 🛠 SQL Concepts Used

- **SUM()** – Calculates total quantity sold.
- **GROUP BY** – Groups products.
- **HAVING** – Excludes products with zero sales.
- **ORDER BY** – Sorts ascending.
- **LIMIT** – Returns bottom 10.

### 🔍 Business Finding

Several products experience consistently low sales.

### 💡 Business Recommendation

Consider discounts, bundling, or reducing inventory for slow-moving products.

---

# 10. Daily Sales Trend

### 🎯 Business Objective

Analyze daily business performance.

### 🛠 SQL Concepts Used

- **COUNT()** – Counts transactions.
- **SUM()** – Calculates revenue.
- **GROUP BY** – Groups by transaction date.
- **ORDER BY** – Sorts chronologically.

### 🔍 Business Finding

Daily sales fluctuate throughout the year.

### 💡 Business Recommendation

Identify high-performing days to optimize promotions and inventory planning.

---

# 11. Month-over-Month Sales Growth

### 🎯 Business Objective

Measure monthly business growth.

### 🛠 SQL Concepts Used

- **CTE** – Simplifies complex calculations.
- **LAG()** – Retrieves previous month's sales.
- **SUM()** – Calculates monthly revenue.
- **MONTH()** – Extracts month.
- **ROUND()** – Formats growth percentages.

### 🔍 Business Finding

Monthly sales show both growth and decline over time.

### 💡 Business Recommendation

Investigate the reasons behind declining months and replicate strategies from high-growth periods.

---

# 12. High-Value Customers

### 🎯 Business Objective

Identify customers with high purchase frequency and spending.

### 🛠 SQL Concepts Used

- **COUNT()** – Counts transactions.
- **SUM()** – Calculates customer spending.
- **GROUP BY** – Aggregates customer data.
- **HAVING** – Filters high-value customers.

### 🔍 Business Finding

A small group of customers contributes a significant portion of total revenue.

### 💡 Business Recommendation

Introduce VIP rewards and personalized marketing campaigns to retain these customers.

---

# 13. Low-Frequency Customers

### 🎯 Business Objective

Identify customers with limited purchasing activity.

### 🛠 SQL Concepts Used

- **COUNT()** – Counts transactions.
- **SUM()** – Calculates spending.
- **GROUP BY** – Groups by customer.
- **HAVING** – Filters occasional buyers.

### 🔍 Business Finding

Many customers purchase only once or twice.

### 💡 Business Recommendation

Launch re-engagement campaigns, discounts, and personalized offers to increase repeat purchases.

---

# 14. Repeat Purchase Analysis

### 🎯 Business Objective

Identify customers repeatedly purchasing the same products.

### 🛠 SQL Concepts Used

- **COUNT()** – Counts purchases.
- **GROUP BY** – Groups customers and products.
- **HAVING** – Filters repeat purchases.

### 🔍 Business Finding

Several customers repeatedly purchase specific products, indicating strong product loyalty.

### 💡 Business Recommendation

Leverage personalized recommendations, subscriptions, and cross-selling opportunities.

---

# 15. Customer Loyalty Analysis

### 🎯 Business Objective

Measure customer loyalty using purchase history.

### 🛠 SQL Concepts Used

- **MIN()** – Finds first purchase.
- **MAX()** – Finds latest purchase.
- **DATEDIFF()** – Calculates customer lifetime.
- **GROUP BY** – Aggregates customer records.
- **HAVING** – Filters active customers.

### 🔍 Business Finding

Customers with longer purchase histories demonstrate stronger loyalty.

### 💡 Business Recommendation

Reward long-term customers with exclusive benefits and loyalty incentives.

---

# 16. Customer Segmentation

### 🎯 Business Objective

Segment customers according to their purchasing behavior for targeted marketing.

### 🛠 SQL Concepts Used

- **LEFT JOIN** – Includes customers without purchases.
- **COALESCE()** – Converts NULL quantities to zero.
- **SUM()** – Calculates total quantity purchased.
- **CASE** – Assigns customer segments.
- **GROUP BY** – Creates one record per customer.
- **COUNT()** – Counts customers in each segment.

### 🔍 Business Finding

Customers were successfully classified into No Orders, Low, Medium, and High Value segments, enabling personalized marketing strategies.

### 💡 Business Recommendation

- **No Orders:** Launch welcome and activation campaigns.
- **Low:** Encourage additional purchases through discounts.
- **Medium:** Strengthen engagement with loyalty rewards.
- **High Value:** Retain customers using VIP benefits, personalized offers, and early product access.
  
---

# 🚀 Technologies Used

- SQL (MySQL)
- MySQL Workbench

Passionate about transforming raw data into actionable business insights through data analysis and visualization.
