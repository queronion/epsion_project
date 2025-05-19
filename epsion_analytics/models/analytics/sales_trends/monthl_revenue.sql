-- total net revenue per MONTH after subtracting retruns WITH revenue AS (
    SELECT
        DATE_TRUNC(
            'MONTH',
            s.order_date
        ) AS order_date,
        SUM(
            s.order_quantity * p.product_price
        ) - SUM(
            r.return_quantity * p.product_price
        ) AS total_revenue
    FROM
        {{ ref('fct_sales') }}
        s
        LEFT JOIN {{ ref('dim_products') }}
        p
        ON s.product_key = p.product_key
        LEFT JOIN {{ ref('fct_returns') }}
        r
        ON r.product_key = p.product_key
    GROUP BY
        1
    ORDER BY
        1
)
SELECT
    *
FROM
    revenue
