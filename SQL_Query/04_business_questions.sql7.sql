CREATE OR REPLACE VIEW vw_q07_store_performance AS
SELECT
    s.Store_ID,
    s.Store_Name,
    s.Country,
    s.City,
    t.Currency,

    ROUND(
        SUM(
            CASE
                WHEN t.Transaction_Type = 'Sale'
                THEN t.Line_Total
                ELSE 0
            END
        ),
        2
    ) AS total_revenue,

    ROUND(
        100.0 *
        COUNT(
            DISTINCT CASE
                WHEN t.Transaction_Type = 'Return'
                THEN t.Invoice_ID
            END
        ) /
        NULLIF(COUNT(DISTINCT t.Invoice_ID), 0),
        2
    ) AS return_rate

FROM vw_clean_transactions t

JOIN vw_clean_stores s
    ON t.Store_ID = s.Store_ID

GROUP BY
    s.Store_ID,
    s.Store_Name,
    s.Country,
    s.City,
    t.Currency;
    
SELECT *
FROM vw_q07_store_performance
WHERE Currency = 'USD'
ORDER BY total_revenue DESC
LIMIT 5;

SELECT *
FROM vw_q07_store_performance
WHERE Currency = 'USD'
ORDER BY total_revenue ASC
LIMIT 5;