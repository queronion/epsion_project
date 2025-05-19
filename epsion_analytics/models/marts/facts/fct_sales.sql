-- Used 'merge' incremental strategy instead of 'append' to ensure updated order records (e.g., changes in quantity, price, or product) 
-- are reflected in the target table.Thereby, avoding duplicate order_number entries and ensures accurate reporting.
-- 'order_number' is used as the unique key to detect updates and perform UPSERT (update or insert).

{{
    config (
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='order_number',
        schema='MARTS',
        alias='fct_sales'
    )
}}


with sales as (
    select 
        *
    from {{ ref('stg_sales') }}
)
select 
    order_date,
    stock_date,
    order_number,
    category_key,
    subcategory_key,
    product_key,
    customer_key,
    territory_key,
    order_line_item,
    order_quantity
from sales

-- load only new records in incremental runs
-- This condition ensures that only new records (those with an order_date greater than the maximum order_date in the target table) are processed during incremental runs.

{% if is_incremental() %}
    where s.order_date > (select max(order_date) from {{ this }})
{% endif %}
