CREATE OR REPLACE VIEW vw_q10_monthly_growth AS

WITH monthly AS
(
    SELECT
        DATE_FORMAT(
            t.Transaction_Date,
            '%Y-%m-01'
        ) AS month_start,

        t.Currency,
        p.Category,
        SUM(t.Line_Total) AS revenue

    FROM vw_clean_transactions t

    JOIN vw_clean_products p
        ON t.Product_ID = p.Product_ID

    WHERE t.Transaction_Type = 'Sale'

    GROUP BY
        month_start,
        t.Currency,
        p.Category
),

combined AS
(
    SELECT
        month_start,
        Currency,
        'Overall' AS revenue_group,
        SUM(revenue) AS revenue

    FROM monthly

    GROUP BY
        month_start,
        Currency

    UNION ALL

    SELECT
        m.month_start,
        m.Currency,
        m.Category AS revenue_group,
        m.revenue

    FROM monthly m

    JOIN vw_q03_category_performance q
        ON m.Category = q.Category
       AND m.Currency = q.Currency

    WHERE q.category_rank <= 3
),

growth AS
(
    SELECT
        month_start,
        Currency,
        revenue_group,
        revenue,

        LAG(revenue) OVER (
            PARTITION BY Currency, revenue_group
            ORDER BY month_start
        ) AS previous_revenue

    FROM combined
)

SELECT
    month_start,
    Currency,
    revenue_group,

    ROUND(revenue, 2) AS revenue,

    ROUND(
        100.0 * (revenue - previous_revenue) /
        NULLIF(previous_revenue, 0),
        2
    ) AS monthly_growth_percentage

FROM growth;


SELECT *
FROM vw_q10_monthly_growth
ORDER BY Currency, revenue_group, month_start;