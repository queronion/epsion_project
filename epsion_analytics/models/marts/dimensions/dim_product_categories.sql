-- This model is used to create a dimension table for product categories in the MARTS schema with the name dim_product_categories.
-- The model is materialized as a table and includes a unique key for each category.

{{ config(
    materialized = 'table',
    schema = 'MARTS',
    unique_key = 'category_key',
    alias = 'dim_product_categories',
) }}

WITH categories AS (

    SELECT
        category_key,
        category_name
    FROM
        {{ ref('stg_product_categories') }}
)
SELECT
    *
FROM
    categories
