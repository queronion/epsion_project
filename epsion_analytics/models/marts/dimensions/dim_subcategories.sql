-- This model is used to create a dimension table for product sub_categories in the MARTS schema with the name dim_sbcategories.
-- The model is materialized as a table and includes a unique key for each subcategory.

{{ config(
    materialized = 'table',
    schema = 'MARTS',
    alias = 'dim_subcategories',
    unique_key = 'subcategory_key'
) }}

WITH subcategories AS (

    SELECT
        subcategory_key,
        subcategory_name,
        category_key
    FROM
        {{ ref('stg_subcategories') }}
)
SELECT
    *
FROM
    subcategories
