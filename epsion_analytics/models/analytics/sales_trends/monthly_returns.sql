-- returned orders per MONTH WITH returns AS (
    SELECT
        DATE_TRUNC(
            'MONTH',
            r.return_date
        ) AS order_date,
        COUNT(*) AS returns
    FROM
        {{ ref('fct_returns') }}
        r
        LEFT JOIN {{ ref('dim_products') }}
        p
        ON r.product_key = p.product_key
    GROUP BY
        1
    ORDER BY
        1
)
SELECT
    *
FROM
    returns
