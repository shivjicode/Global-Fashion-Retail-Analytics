USE global_fashion_retail;

CREATE OR REPLACE VIEW vw_q01_customer_demographics AS
SELECT
    c.Country,
    c.City,
    t.Currency,
    COUNT(DISTINCT t.Customer_ID) AS unique_customers,
    COUNT(DISTINCT t.Invoice_ID) AS total_purchases,
    ROUND(SUM(t.Line_Total), 2) AS total_revenue,
    ROUND(
        SUM(t.Line_Total) /
        NULLIF(COUNT(DISTINCT t.Invoice_ID), 0),
        2
    ) AS average_purchase_value
FROM vw_clean_transactions t
INNER JOIN vw_clean_customers c
    ON t.Customer_ID = c.Customer_ID
WHERE t.Transaction_Type = 'Sale'
GROUP BY
    c.Country,
    c.City,
    t.Currency;
    
SELECT *
FROM vw_q01_customer_demographics
ORDER BY total_revenue DESC
LIMIT 100;