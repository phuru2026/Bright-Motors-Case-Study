# Bright Motors Case Study

## Project Overview

This project presents an **interactive data analysis dashboard** built using SQL and Google Looker Studio.
The goal is to transform raw car sales data into **clear, actionable insights** that support better business decision-making as a Data Analyst

The dataset includes information on vehicle attributes, pricing, condition, and transaction details. Through data cleaning, transformation, and visualization, this project uncovers **sales trends, pricing performance, and customer preferences**.

---

## 🎯 Objectives

* Clean and prepare raw data for analysis
* Convert inconsistent data types into usable formats
* Derive key business metrics (revenue, profit margin, performance)
* Analyze trends over time using time series
* Build an interactive dashboard for exploration.

  ---
  ##  Project Planning

This project followed a structured workflow to ensure clarity, consistency, and efficiency from raw data to final dashboard.

🧩 Project Flowchart
<img width="1866" height="848" alt="Screenshot 2026-05-01 015732" src="https://github.com/user-attachments/assets/423a7b61-eacb-4d39-b4c6-b656f911c464" />

---

## Tools & Technologies used

* **SQL (Databricks / Spark SQL)** – Data cleaning & transformation
* **Google Looker Studio** – Data visualization & dashboard creation
* **Excel / CSV** – Data storage and import
* **Notebooklm and Lovable**- Data Presentation

---

## Data Cleaning & Preparation

The dataset required extensive preprocessing to ensure accuracy and usability:

* Converted text-based numeric fields (`mmr`, `sellingprice`, `total_revenue`) into numeric format
* Parsed string-based date fields into proper timestamps
* Extracted:

  * `sale_date`
  * `sale_month`
  * `sale_quarter`
  * `day_name`
* Handled missing values:

  * Replaced NULLs with meaningful labels (e.g., *Unknown*)
  * Removed invalid records where necessary
* Standardized categorical fields (color, interior, transmission)

---

## Key Metrics Created

* **Total Revenue** = Selling Price
* **Profit Margin (%)** = `(sellingprice - mmr) / sellingprice * 100`

---

## Dashboard Features


### 🔹 Comparative Analysis

* Top Car Makes by Revenue
* Revenue by State

### 🔹 Distribution Analysis

* Revenue Share by Profit Category
* Sales Distribution by Transmission Type
* Car Color Preferences

### 🔹 Stacked Insights

* Revenue by Market Performance across Quarters

---

##  Interactivity

The dashboard includes dynamic filters for:

* Car Make
* Year / Time Period
* State
* Profit Category
* Transmission

These allow users to **drill down into specific segments** and explore patterns interactively.

---

## 🔍 Key Insights

* Certain car brands consistently generate higher revenue over time
* Vehicles sold above market value contribute significantly to profitability
* Automatic transmission vehicles dominate sales volume
* Revenue patterns vary across different days and quarters

---

## 📌 Conclusion

This project demonstrates how raw data can be transformed into **meaningful insights through structured analysis and visualization**.
The interactive dashboard enables stakeholders to monitor performance, identify trends, and make **data-driven decisions**.

---

##  How to Use Looker Studio

1. Open the dashboard in Google Looker Studio <https://datastudio.google.com/s/k9gfA1Bn1-A>
2. Use filters to explore different segments
3. Hover over charts for detailed insights
4. Analyze trends and compare performance across categories
