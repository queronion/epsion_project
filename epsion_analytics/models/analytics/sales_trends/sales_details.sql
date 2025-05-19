-- total sales performance over THE three years before subtracting returns WITH sales_details AS (
    SELECT
        d.year,
        COUNT(
            s.order_number
        ) AS total_orders,
        SUM(
            s.order_quantity
        ) AS sold_units,
        ROUND(SUM(p.product_price * s.order_quantity)) AS revenue,
        ROUND(SUM(p.product_price * s.order_quantity) - SUM(p.product_cost * s.order_quantity)) AS profit
    FROM
        {{ ref('fct_sales') }}
        s
        LEFT JOIN {{ ref('dim_dates') }}
        d
        ON s.order_date = d.date
        LEFT JOIN {{ ref('dim_products') }}
        p
        ON s.product_key = p.product_key
    GROUP BY
        1
)
SELECT
    *
FROM
    sales_details
