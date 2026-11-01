CREATE OR REPLACE VIEW vw_q04_payment_performance AS
SELECT
    Payment_Method,
    Currency,

    COUNT(DISTINCT Invoice_ID) AS total_baskets,

    SUM(Quantity) AS total_items_sold,

    ROUND(SUM(Line_Total), 2) AS total_revenue,

    ROUND(
        SUM(Line_Total) /
        NULLIF(COUNT(DISTINCT Invoice_ID), 0),
        2
    ) AS average_basket_value,

    ROUND(
        SUM(Quantity) /
        NULLIF(COUNT(DISTINCT Invoice_ID), 0),
        2
    ) AS average_items_per_basket

FROM vw_clean_transactions

WHERE Transaction_Type = 'Sale'

GROUP BY
    Payment_Method,
    Currency;
    

SELECT *
FROM vw_q04_payment_performance
ORDER BY Currency, total_revenue DESC;