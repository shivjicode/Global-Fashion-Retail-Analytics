CREATE OR REPLACE VIEW vw_q03_category_performance AS
SELECT
    p.Category,
    t.Currency,

    ROUND(SUM(t.Line_Total), 2) AS total_revenue,

    ROUND(
        100.0 * SUM(t.Line_Total)
        / SUM(SUM(t.Line_Total)) OVER (
            PARTITION BY t.Currency
        ),
        2
    ) AS revenue_share_percentage,

    DENSE_RANK() OVER (
        PARTITION BY t.Currency
        ORDER BY SUM(t.Line_Total) DESC
    ) AS category_rank

FROM vw_clean_transactions t

INNER JOIN vw_clean_products p
    ON t.Product_ID = p.Product_ID

WHERE t.Transaction_Type = 'Sale'

GROUP BY
    p.Category,
    t.Currency;
    

SELECT *
FROM vw_q03_category_performance
ORDER BY Currency, category_rank;