CREATE OR REPLACE VIEW vw_q08_price_bands AS

WITH price_summary AS
(
    SELECT
        Currency,

        CASE
            WHEN Unit_Price < 25 THEN 'Low: Below 25'
            WHEN Unit_Price < 50 THEN 'Medium: 25-49'
            WHEN Unit_Price < 100 THEN 'High: 50-99'
            ELSE 'Premium: 100+'
        END AS price_band,

        SUM(
            CASE
                WHEN Transaction_Type = 'Sale'
                THEN Line_Total
                ELSE 0
            END
        ) AS sales_revenue,

        ABS(
            SUM(
                CASE
                    WHEN Transaction_Type = 'Return'
                    THEN Line_Total
                    ELSE 0
                END
            )
        ) AS returned_value

    FROM vw_clean_transactions

    GROUP BY
        Currency,
        price_band
)

SELECT
    Currency,
    price_band,
    ROUND(sales_revenue, 2) AS sales_revenue,
    ROUND(returned_value, 2) AS returned_value,

    ROUND(
        100 * sales_revenue /
        SUM(sales_revenue) OVER (PARTITION BY Currency),
        2
    ) AS revenue_share_percentage,

    ROUND(
        100 * returned_value /
        NULLIF(
            SUM(returned_value) OVER (PARTITION BY Currency),
            0
        ),
        2
    ) AS return_share_percentage

FROM price_summary;


SELECT *
FROM vw_q08_price_bands
ORDER BY Currency, sales_revenue DESC;