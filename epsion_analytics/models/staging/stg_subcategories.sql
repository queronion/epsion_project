-- This table is used to stage the product subcategories data from the source table 
-- and acts as the base for further transformations in the marts layer, so it can be suitable for analysis.

WITH src_subcategories AS (
    SELECT
        *
    FROM
        {{ source(
            'epsion_raw',
            'product_subcategories'
        ) }}
),
stg_subcategories AS (
    SELECT
        _airbyte_raw_id,
        _airbyte_extracted_at,
        _airbyte_meta,
        _airbyte_generation_id,
        TRIM(productsubcategorykey) AS subcategory_key,
        TRIM(INITCAP(subcategoryname)) AS subcategory_name,
        TRIM(productcategorykey) AS category_key
    FROM
        src_subcategories
)
SELECT
    *
FROM
    stg_subcategories
