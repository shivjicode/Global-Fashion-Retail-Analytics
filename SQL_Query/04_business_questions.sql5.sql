CREATE OR REPLACE VIEW vw_q05_promotion_impact AS
SELECT
    CASE
        WHEN Discount > 0 THEN 'Promotional'
        ELSE 'Non-Promotional'
    END AS promotion_status,

    Currency,

    COUNT(DISTINCT Invoice_ID) AS total_baskets,

    SUM(Quantity) AS total_items_sold,

    COUNT(DISTINCT DATE(Transaction_Date)) AS active_sales_days,

    ROUND(
        AVG(Discount) * 100,
        2
    ) AS average_discount_percentage,

    ROUND(
        SUM(Unit_Price * Quantity),
        2
    ) AS gross_sales_value,

    ROUND(
        SUM(Line_Total),
        2
    ) AS net_revenue,

    ROUND(
        SUM(Line_Total) /
        NULLIF(COUNT(DISTINCT Invoice_ID), 0),
        2
    ) AS average_basket_value,

    ROUND(
        SUM(Line_Total) /
        NULLIF(COUNT(DISTINCT DATE(Transaction_Date)), 0),
        2
    ) AS average_daily_revenue

FROM vw_clean_transactions

WHERE Transaction_Type = 'Sale'

GROUP BY
    CASE
        WHEN Discount > 0 THEN 'Promotional'
        ELSE 'Non-Promotional'
    END,
    Currency;
    
    

SELECT *
FROM vw_q05_promotion_impact
ORDER BY Currency, promotion_status;