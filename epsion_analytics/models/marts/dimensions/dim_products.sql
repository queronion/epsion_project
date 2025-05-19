-- This model is used to create a dimension table for products in the MARTS schema with the name dim_products.
-- The model is materialized as a table and includes a unique key for each product. 


{{ config(
    materialized = 'table',
    schema = 'MARTS',
    unique_key = 'product_key',
    alias = 'dim_products'
) }}

WITH products AS (

    SELECT
        product_key,
        product_name,
        product_sku,
        model_name,
        product_size,
        product_color,
        product_style,
        product_description,
        subcategory_key,
        product_price,
        product_cost
    FROM
        {{ ref('stg_products') }}
)
SELECT
    *
FROM
    products
