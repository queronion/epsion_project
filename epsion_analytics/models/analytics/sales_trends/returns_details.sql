WITH return_details AS (
    SELECT
        d.year,
        COUNT(
            r.*
        ) AS cancelled_orders,
        SUM(
            r.return_quantity
        ) AS returned_units,
        ROUND(SUM(p.product_price * r.return_quantity)) AS lost_revenue,
        ROUND(SUM(p.product_price * r.return_quantity) - SUM(p.product_cost * r.return_quantity)) AS lost_profit
    FROM
        {{ ref('fct_returns') }}
        r
        LEFT JOIN {{ ref('dim_dates') }}
        d
        ON r.return_date = d.date
        LEFT JOIN {{ ref('dim_products') }}
        p
        ON r.product_key = p.product_key
    GROUP BY
        1
)
SELECT
    *
FROM
    return_details
