-- total net profit per MONTH after subtracting retruns WITH monthly_profit AS (
    SELECT
        DATE_TRUNC(
            'MONTH',
            s.order_date
        ) AS DATE,
        SUM(
            s.order_quantity * p.product_price
        ) - SUM(
            p.product_cost * s.order_quantity
        ) AS total_profit,
        SUM(
            r.return_quantity * p.product_price
        ) - SUM(
            p.product_cost * r.return_quantity
        ) AS lost_profit,
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
    DATE,
    total_profit - lost_profit AS net_profit
FROM
    monthly_profit
