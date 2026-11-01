CREATE OR REPLACE VIEW vw_q09_basket_country AS

WITH baskets AS
(
    SELECT
        s.Country,
        t.Currency,
        t.Invoice_ID,
        SUM(t.Quantity) AS basket_items,
        SUM(t.Line_Total) AS basket_revenue

    FROM vw_clean_transactions t

    JOIN vw_clean_stores s
        ON t.Store_ID = s.Store_ID

    WHERE t.Transaction_Type = 'Sale'

    GROUP BY
        s.Country,
        t.Currency,
        t.Invoice_ID
)

SELECT
    Country,
    Currency,
    COUNT(*) AS total_baskets,

    ROUND(
        AVG(basket_items),
        2
    ) AS average_items_per_basket,

    ROUND(
        AVG(basket_revenue),
        2
    ) AS average_revenue_per_basket,

    ROUND(
        SUM(basket_revenue),
        2
    ) AS total_revenue

FROM baskets

GROUP BY
    Country,
    Currency;
    

SELECT *
FROM vw_q09_basket_country
ORDER BY Currency, average_revenue_per_basket DESC;