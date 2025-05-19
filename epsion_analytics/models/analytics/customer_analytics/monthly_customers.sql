-- kpi that shows total monthly customers

WITH customers AS (
    SELECT
        DATE_TRUNC(
            'MONTH',
            order_date
        ) AS order_date,
        COUNT(
            DISTINCT customer_key
        ) AS total_customers
    FROM
        {{ref('fct_sales')}} 
    GROUP BY
        1
    ORDER BY
        1
)
SELECT
    *
FROM
    customers
