-- This model is used to create a dimension table for territories in the MARTS schema with the name dim_territories.
-- The model is materialized as a table and includes a unique key for each territory.

{{ config(
    materialized = 'table',
    schema = 'MARTS',
    alias = 'dim_territories',
    unique_key = 'territory_key'
) }}

WITH territories AS (

    SELECT
        territory_key,
        continent,
        region,
        country
    FROM
        {{ ref('stg_territories') }}
)
SELECT
    *
FROM
    territories
