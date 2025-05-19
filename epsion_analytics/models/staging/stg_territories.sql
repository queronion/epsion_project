WITH src_territory AS (
    SELECT
        *
    FROM
        {{ source(
            'epsion_raw',
            'territory'
        ) }}
),
stg_territory AS (
    SELECT
        _airbyte_raw_id,
        _airbyte_extracted_at,
        _airbyte_meta,
        _airbyte_generation_id,
        TRIM(salesterritorykey) AS territory_key,
        TRIM(INITCAP(continent)) AS continent,
        TRIM(INITCAP(region)) AS region,
        TRIM(INITCAP(country)) AS country
    FROM
        src_territory)
    SELECT
        *
    FROM
        stg_territory
