# 📊 California Wildfire Analysis (SQL Project)

## 🔹 Overview
This project analyzes wildfire incidents in California using SQL.  
The goal is to identify patterns in wildfire occurrences, financial impact, causes, and regional trends.

The dataset was imported from a CSV file into SQL Server and analyzed using SQL queries.

---

## 🔹 Dataset
- Source: Wildfire dataset (CSV format)
- Contains:
  - Incident ID, Date, Location
  - Area Burned (Acres)
  - Homes, Businesses, Vehicles Damaged
  - Injuries & Fatalities
  - Estimated Financial Loss (Million $)
  - Cause of wildfire

---

## 🔹 Tools & Technologies
- SQL Server Management Studio (SSMS)
- SQL (T-SQL)
- CSV Dataset

---

## 🔹 Key Insights

- 🔥 Total area burned: **2.6+ million acres**
- 💰 Average financial loss per wildfire: **~$2,396 million**
- ⚠️ Human activity is the **leading cause of wildfires**
- 📍 Shasta County is the **most affected region**
- 📉 Wildfire damage shows **yearly fluctuations**

---


## 🔹 SQL Techniques Used

### Basic SQL:
- SELECT, WHERE
- GROUP BY, ORDER BY
- Aggregate functions (SUM, AVG, COUNT)

### Intermediate:
- CASE statements (Severity classification)

### Advanced (Window Functions):
- `RANK()` → Ranking wildfires by financial loss
- `PARTITION BY` → Ranking within each location
- `LAG()` → Year-on-year comparison
- `SUM() OVER()` → Cumulative financial loss
- `NTILE()` → Grouping wildfires into quartiles
- Moving Average → Trend smoothing

---
<img width="2752" height="1536" alt="unnamed (2)" src="https://github.com/user-attachments/assets/0d32c49a-ea59-4de1-bfdc-d6c20913c2b9" />
---

## 🔹 Key Queries Performed

- Total area burned and financial loss
- Top 5 most destructive wildfires
- Location-based damage analysis
- Cause-based analysis
- Yearly trends and patterns
- Severity classification using CASE
- Ranking and trend analysis using window functions

---

## 🔹 Conclusion

Wildfires in California have a significant environmental and economic impact.  
Human activity plays a major role in wildfire incidents, and certain regions are more vulnerable.

This analysis helps in understanding wildfire trends and supports better decision-making for prevention and resource allocation.

---

## 👤 Author

**Mohd Fazal Hussain**  
MSc Banking & Financial Analytics  
Aspiring Data Analyst  

---
