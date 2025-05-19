WITH src_product_categories AS (
    SELECT
        *
    FROM
        {{ source(
            'epsion_raw',
            'product_categories'
        ) }}
),
stg_product_categories AS (
    SELECT
        _airbyte_raw_id,
        _airbyte_extracted_at,
        _airbyte_meta,
        _airbyte_generation_id,
        TRIM(productcategorykey) AS category_key,
        TRIM(INITCAP(categoryname)) AS category_name
    FROM
        src_product_categories)
    SELECT
        *
    FROM
        stg_product_categories
