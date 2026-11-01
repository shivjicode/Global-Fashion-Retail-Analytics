# Global Fashion Retail Analytics

## Project Overview

This end-to-end retail analytics project examines sales, returns, geographic performance, product categories, promotions, and customer behaviour. The analysis uses more than **6.4 million transaction records** and converts raw CSV data into business insights through Python, MySQL, and Power BI.

## Business Objective

The objective was to build a reliable analytical solution that helps decision-makers:

- Monitor revenue, returns, and basket size.
- Compare stores, countries, cities, categories, and products.
- Evaluate the effectiveness of discounts and promotions.
- Understand new, repeat, and value-based customer segments.
- Explore performance through interactive filters and drill-downs.

## Dataset

Six source files were used:

| Dataset | Purpose |
|---|---|
| Customers | Customer profile and demographic attributes |
| Products | Product, category, and pricing information |
| Stores | Store and geographic information |
| Transactions | Main fact table containing retail transactions |
| Discounts | Promotion and discount details |
| Returns | Returned transaction information |

> The raw transaction data is not included in this repository because of its large size. Add a sample or a data-source link if redistribution is permitted.

## Tools and Techniques

- **Python and Pandas:** data inspection, cleaning, validation, and CSV processing
- **MySQL Workbench:** database storage and business analysis
- **SQL:** joins, CTEs, subqueries, aggregations, views, and window functions
- **ODBC Connector:** MySQL-to-Power BI connectivity
- **Power Query:** transformation and data-type validation
- **Power BI and DAX:** data modelling, KPI measures, interactive visuals, slicers, and drill-downs

## Project Workflow

1. Collected and reviewed six retail CSV datasets.
2. Cleaned and validated data using Python and Pandas.
3. Loaded the prepared data into MySQL.
4. Created reusable clean views and answered business questions with SQL.
5. Connected MySQL to Power BI through ODBC.
6. Built a relational model with a calendar table and DAX measures.
7. Developed five interactive dashboard pages.
8. Validated key totals across Python, MySQL, and Power BI.

## Dashboard Pages

1. **Sales & Returns Overview** – revenue, returns, basket size, monthly trends, categories, and payment methods
2. **Geographic Insights** – country, city, regional spend, and sales trends
3. **Category & Product Insights** – category revenue, return rates, product ranking, and monthly category trends
4. **Promotion Effectiveness** – promotional revenue, sales lift, promotional share, and discount patterns
5. **Customer Behaviour** – new vs repeat customers, average order value, customer segments, and loyalty trends

## Key Insights

- Total sales revenue reached **776.06M**.
- The overall return rate was **4.47%**.
- Average basket size was **1.54 items** per invoice.
- Credit cards contributed approximately **80.09%** of revenue.
- The **Feminine** category led with approximately **360.91M** in revenue.
- Repeat customers represented **75.08%**, compared with **24.92%** new customers.
- Promotional revenue reached **144.16M**, while promotional sales lift was **-46.90%** against the selected regular-sales baseline.

## Business Recommendations

- Review promotion targeting, discount depth, product selection, and comparison periods.
- Prioritise retention campaigns for high-value repeat customers.
- Investigate products, categories, and stores with elevated return rates.
- Align inventory and marketing decisions with regional and category demand.
- Track KPI targets over time and add cohort or customer-lifetime-value analysis in a future version.


**Shivji**  
GitHub: [shivjicode](https://github.com/shivjicode)

