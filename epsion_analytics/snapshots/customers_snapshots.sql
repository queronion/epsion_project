-- Created a snapshot to track changes in the customers profile (email, income, marital status, etc.)
-- This snapshot will help in tracking the changes over time and maintaining historical records.

{% snapshot customers_snapshot %}
{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='customer_key',
        strategy='check',
        check_cols=[
            'email_address',
            'marital_status',
            'total_children',
            'is_parent',
            'annual_income',
            'education_level',
            'occupation',
            'is_homeowner'
        ]
    )
}}

SELECT
    customer_key,
    prefix,
    first_name,
    last_name,
    gender,
    birth_date,
    email_address,
    annual_income,
    marital_status,
    total_children,
    is_parent,
    is_homeowner,
    education_level,
    occupation
FROM {{ ref('stg_customers') }}
{% endsnapshot %}