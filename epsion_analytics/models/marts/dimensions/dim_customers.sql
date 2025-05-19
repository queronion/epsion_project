-- This model is used to create a dimension table for customers in the MARTS schema with the name dim_customers. 
-- The model is materialized as an incremental table and includes various customer attributes such as full name, gender, email....etc
-- The model uses several macros to clean and transform the data, including cleaning the full name



{{ config(
    materialized = 'incremental',
    unique_key = 'customer_key',
    incremental_strategy = 'insert_overwrite',
    schema = 'MARTS',
    alias = 'dim_customers'
) }}

WITH customers AS (

    SELECT
        customer_key,
        {{ clean_full_name(
            'prefix',
            'first_name',
            'last_name'
        ) }} AS full_name,
        {{ clean_gender('gender') }} AS gender,
        email_address,
        birth_date,
        {{ calculate_age('birth_date') }} AS age,
        annual_income,
        {{ clean_marital_status('marital_status') }} AS marital_status,
        total_children,
        {{ clean_binary_flag('is_homeowner') }} AS is_homeowner,
        {{ clean_education('education_level') }} AS education_level,
        occupation
    FROM
        {{ ref('stg_customers') }}
)
SELECT
    *
FROM
    customers
ORDER BY
    customer_key
