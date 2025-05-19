-- This table is used to stage the products data from the source table
-- and transform it into a format suitable for analysis.


WITH src_products AS (
    SELECT
        *
    FROM
        {{ source(
            'epsion_raw',
            'products'
        ) }}
),
stg_products AS (
    SELECT
        _airbyte_raw_id,
        _airbyte_extracted_at,
        _airbyte_meta,
        _airbyte_generation_id,
        TRIM(productkey) AS product_key,
        TRIM(INITCAP(productname)) AS product_name,
        TRIM(productsku) AS product_sku,
        TRIM(INITCAP(modelname)) AS model_name,
        TRIM(productsize) AS product_size,
        TRIM(INITCAP(productcolor)) AS product_color,
        TRIM(productstyle) AS product_style,
        TRIM(productdescription) AS product_description,
        {{ cast_column_to(
            'productprice',
            'DECIMAL(10, 2)'
        ) }} AS product_price,
        {{ cast_column_to(
            'productcost',
            'DECIMAL(10, 2)'
        ) }} AS product_cost,
        TRIM(productsubcategorykey) AS subcategory_key
    FROM
        src_products
)
SELECT
    *
FROM
    stg_products
ORDER BY
    product_price DESC
