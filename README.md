# Kimia Farma Performance Analysis (2020-2023)

This project aims to analyze the performance of Kimia Farma from 2020 to 2023. The analysis includes various aspects such as sales, profits, and branch performance. The processed data will be used to create an interactive dashboard using **Google Looker Studio**.

## Objective
Before building the dashboard, data is analyzed and processed using SQL queries to create an analysis table. This table combines transaction, branch, and product data to provide the following information:

- **Net Sales:** Calculates total sales after discounts.
- **Net Profit:** Calculates net profit based on gross profit percentages.
- **Product and Branch Information:** Includes product name, branch location, and branch rating.

## Approach
The SQL query uses several *Common Table Expressions* (CTEs) to process the data:

1. **Subquery `main`:**
   - Combines transaction, branch, and product data.
   - Calculates gross profit percentages based on price ranges.
   - Adds branch information (location and rating).
   - Adds product information.

2. **Additional Calculations:**
   - **Net Profit:** Calculated using actual price, gross profit percentage, and discount.
   - **Transaction Rating:** Added for each transaction.

3. **Data Ordering:**
   - Transactions are ordered by date (ascending).

## Results
The final query output is stored in the `analysis_table`. This table will be linked to build an interactive dashboard in **Google Looker Studio**. The dashboard provides insights into sales performance, profits, and branch operations.

## Dashboard Access
The dashboard can be accessed via the following link: (https://lookerstudio.google.com/reporting/1af9ddef-d58e-4e17-b9fa-38f53c1de4d1)(#).

## Query Structure
Here is an overview of the process in the SQL query:
- **Gross Profit Percentage:** Determines gross profit based on price ranges.
- **Net Sales:** Reduces discounts from the original price.
- **Net Profit:** Uses gross profit and net sales to calculate the final profit.
- **Product and Branch Information:** Adds product names, branch locations, and ratings.
