CREATE OR REPLACE VIEW vw_q06_customer_loyalty AS

WITH invoice_sales AS
(
    SELECT
        Invoice_ID,
        Customer_ID,
        Currency,

        CAST(
            DATE_FORMAT(Transaction_Date, '%Y-%m-01')
            AS DATE
        ) AS month_start,

        SUM(Line_Total) AS invoice_revenue

    FROM vw_clean_transactions

    WHERE Transaction_Type = 'Sale'

    GROUP BY
        Invoice_ID,
        Customer_ID,
        Currency,
        CAST(
            DATE_FORMAT(Transaction_Date, '%Y-%m-01')
            AS DATE
        )
),

customer_monthly AS
(
    SELECT
        month_start,
        Customer_ID,
        Currency,
        SUM(invoice_revenue) AS monthly_customer_spend

    FROM invoice_sales

    GROUP BY
        month_start,
        Customer_ID,
        Currency
),

first_purchase AS
(
    SELECT
        Customer_ID,
        MIN(month_start) AS first_purchase_month

    FROM customer_monthly

    GROUP BY Customer_ID
),

classified_customers AS
(
    SELECT
        cm.month_start,
        cm.Customer_ID,
        cm.Currency,
        cm.monthly_customer_spend,

        CASE
            WHEN cm.month_start = fp.first_purchase_month
                THEN 'New'
            ELSE 'Repeat'
        END AS customer_type

    FROM customer_monthly cm

    INNER JOIN first_purchase fp
        ON cm.Customer_ID = fp.Customer_ID
)

SELECT
    month_start,
    Currency,
    customer_type,

    COUNT(*) AS customer_count,

    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (
            PARTITION BY month_start, Currency
        ),
        2
    ) AS customer_percentage,

    ROUND(
        AVG(monthly_customer_spend),
        2
    ) AS average_customer_spend,

    ROUND(
        SUM(monthly_customer_spend),
        2
    ) AS total_customer_revenue

FROM classified_customers

GROUP BY
    month_start,
    Currency,
    customer_type;
    
    
SELECT *
FROM vw_q06_customer_loyalty
ORDER BY month_start, Currency, customer_type;