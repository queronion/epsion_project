WITH src_sales AS (
    SELECT
        *
    FROM
        {{ source(
            'epsion_raw',
            'sales'
        ) }}
),
stg_sales AS (
    
    SELECT
        _airbyte_raw_id,
        _airbyte_extracted_at,
        _airbyte_meta,
        _airbyte_generation_id,
        TRIM(ordernumber) AS order_number,
        {{ cast_column_to('orderdate', 'DATE')}} AS order_date,
        {{ cast_column_to('stockdate', 'DATE')}} AS stock_date,
        trim(productsubcategorykey) as subcategory_key,
        trim(productcategorykey) as category_key,
        TRIM(productkey) AS product_key,
        TRIM(customerkey) AS customer_key,
        TRIM(territorykey) AS territory_key,
        TRIM(orderlineitem) AS order_line_item,
        {{ cast_column_to('orderquantity', 'INT')}} AS order_quantity
    FROM
        src_sales
)
SELECT
    *
FROM
    stg_sales

