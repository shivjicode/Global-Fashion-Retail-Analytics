CREATE OR REPLACE VIEW vw_q02_monthly_returns AS
SELECT
    CAST(
        DATE_FORMAT(Transaction_Date, '%Y-%m-01')
        AS DATE
    ) AS month_start,

    COUNT(DISTINCT Invoice_ID) AS total_transactions,

    COUNT(
        DISTINCT CASE
            WHEN Transaction_Type = 'Sale'
            THEN Invoice_ID
        END
    ) AS sales_transactions,

    COUNT(
        DISTINCT CASE
            WHEN Transaction_Type = 'Return'
            THEN Invoice_ID
        END
    ) AS return_transactions,

    ROUND(
        100.0 *
        COUNT(
            DISTINCT CASE
                WHEN Transaction_Type = 'Return'
                THEN Invoice_ID
            END
        )
        / NULLIF(COUNT(DISTINCT Invoice_ID), 0),
        2
    ) AS return_percentage

FROM vw_clean_transactions

GROUP BY
    CAST(
        DATE_FORMAT(Transaction_Date, '%Y-%m-01')
        AS DATE
    );
    
    

SELECT *
FROM vw_q02_monthly_returns
ORDER BY month_start;