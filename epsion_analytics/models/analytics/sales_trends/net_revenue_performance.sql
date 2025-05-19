-- line chart that compares between net revenue over months during 2023, 2024, and 2025

WITH revenue AS (
    SELECT
        d.month,
        d.month_name,
        ROUND(
            SUM(
                CASE
                    WHEN d.year = 2023 THEN p.product_price * s.order_quantity
                END
            )
        ) AS revenue_2023,
        ROUND(
            SUM(
                CASE
                    WHEN d.year = 2024 THEN p.product_price * s.order_quantity
                END
            )
        ) AS revenue_2024,
        ROUND(
            SUM(
                CASE
                    WHEN d.year = 2025 THEN p.product_price * s.order_quantity
                END
            )
        ) AS revenue_2025
    FROM
        {{ref('fct_sales')}} s
        LEFT JOIN {{ref('dim_dates')}} d
        ON s.order_date = d.date
        LEFT JOIN {{ref('dim_products')}}  p
        ON s.product_key = p.product_key
    GROUP BY
        1,
        2
    ORDER BY
        1
),
lost_revenue AS (
    SELECT
        d.month,
        d.month_name,
        ROUND(
            SUM(
                CASE
                    WHEN d.year = 2023 THEN p.product_price * r.return_quantity
                END
            )
        ) AS lost_revenue_2023,
        ROUND(
            SUM(
                CASE
                    WHEN d.year = 2024 THEN p.product_price * r.return_quantity
                END
            )
        ) AS lost_revenue_2024,
        ROUND(
            SUM(
                CASE
                    WHEN d.year = 2025 THEN p.product_price * r.return_quantity
                END
            )
        ) AS lost_revenue_2025
    FROM
        {{ref('fct_returns')}} r
        LEFT JOIN {{ref('dim_dates')}} d
        ON r.return_date = d.date
        LEFT JOIN {{ref('dim_products')}}  p
        ON r.product_key = p.product_key
    GROUP BY
        1,
        2
    ORDER BY
        1
)
SELECT
    r.month,
    r.month_name,
    revenue_2023 - lost_revenue_2023 AS net_revenue_2023,
    revenue_2024 - lost_revenue_2024 AS net_revenue_2024,
    revenue_2025 - lost_revenue_2025 AS net_revenue_2025
FROM
    revenue r
    LEFT JOIN lost_revenue ls
    ON r.month = ls.month;
