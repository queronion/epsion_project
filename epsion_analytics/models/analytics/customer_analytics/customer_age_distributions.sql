-- A histogram that shows total customers per specific age WITH ages_distribution AS (
    SELECT
        age,
        COUNT(*) AS COUNT
    FROM
        {{ref('dim_customers')}}
    GROUP BY
        1
    ORDER BY
        1 DESC
)
SELECT
    *
FROM
    ages_distribution
