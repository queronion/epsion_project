-- TABLE that shows customers rfm analysis
AND helps IN customer segemnation WITH customer_orders AS (
    SELECT
        s.customer_key,
        MAX(
            s.order_date
        ) AS last_order_date,
        COUNT(
            DISTINCT s.order_date
        ) AS frequency,
        SUM(
            s.order_quantity * p.product_price
        ) AS monetary
    FROM
        {{ref('fct_sales')}} s
        LEFT JOIN {{ref('dim_products')}}  p
        ON s.product_key = p.product_key
    GROUP BY
        1
),
reference_date AS (
    SELECT
        MAX(order_date) AS max_date
    FROM
        epsion_raw_marts.fct_sales
),
base_rfm AS (
    SELECT
        C.customer_key,
        (
            r.max_date - C.last_order_date
        ) AS recency,
        C.frequency,
        ROUND(
            C.monetary,
            2
        ) AS monetary
    FROM
        customer_orders C
        CROSS JOIN reference_date r
),
scored_rfm AS (
    SELECT
        customer_key,
        recency,
        frequency,
        monetary,
        NTILE(5) over (
            ORDER BY
                recency ASC
        ) AS r_score,
        NTILE(5) over (
            ORDER BY
                frequency DESC
        ) AS f_score,
        NTILE(5) over (
            ORDER BY
                monetary DESC
        ) AS m_score
    FROM
        base_rfm
)
SELECT
    customer_key,
    recency,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    (
        r_score || f_score || m_score
    ) AS rfm_segment
FROM
    scored_rfm
ORDER BY
    r_score DESC,
    f_score DESC,
    m_score DESC;
