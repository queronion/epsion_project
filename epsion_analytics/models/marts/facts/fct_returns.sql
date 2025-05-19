{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='_airbyte_raw_id',
        schema='MARTS',
        alias='fct_returns'
    )
}}

with fct_returns as (
    select 
    *
    from {{ ref('stg_returns') }}
)
select 
    return_date,
    territory_key,
    product_key,
    return_quantity
from fct_returns
