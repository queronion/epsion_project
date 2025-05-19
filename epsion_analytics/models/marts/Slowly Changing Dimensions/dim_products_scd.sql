-- This table reads from the product snapshot table and adds an `is_current` flag
-- to identify the latest version of each product record.
-- It is used as a Slowly Changing Dimension (Type 2) table to preserve the full
-- history of price changes and product attributes over time.
-- `dbt_valid_to` is null for the current version of the record.


select 
    *,
    case
        when dbt_valid_to is null then 1
        else 0
    end as is_current
from {{ ref('products_snapshots') }}