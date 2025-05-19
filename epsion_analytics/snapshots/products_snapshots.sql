-- Created a snapshot to track changes in the product price, cost
-- This snapshot will help in tracking the changes over time and maintaining historical records.

{%snapshot products_snapshots%}

{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='product_key',
        strategy='check',
        check_cols=[
            'product_price',
            'product_cost'
        ]
    )
}}

select 
    product_key,
    product_name,
    product_price,
    product_cost
from {{ ref('stg_products') }}
{% endsnapshot %}