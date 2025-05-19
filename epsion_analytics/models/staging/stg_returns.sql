WITH src_returns AS (
    SELECT
        *
    FROM
        {{ source(
            'epsion_raw',
            'returns'
        ) }}
),
stg_returns AS (
    SELECT
        _airbyte_raw_id,
        _airbyte_extracted_at,
        _airbyte_meta,
        _airbyte_generation_id,
        {{ cast_column_to(
            'returndate',
            'DATE'
        ) }} AS return_date,
        TRIM(territorykey) AS territory_key,
        TRIM(productkey) AS product_key,
        {{ cast_column_to(
            'returnquantity',
            'INT'
        ) }} AS return_quantity
    FROM
        src_returns
)
SELECT
    *
FROM
    stg_returns
