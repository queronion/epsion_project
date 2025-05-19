WITH src_customers AS (
    SELECT
        *
    FROM
        {{ source(
            'epsion_raw',
            'customers'
        ) }}
),
stg_customers AS (
    SELECT
        _airbyte_raw_id,
        _airbyte_extracted_at,
        _airbyte_meta,
        _airbyte_generation_id,
        TRIM(customerkey) AS customer_key,
        TRIM(initcap(prefix)) AS prefix,
        TRIM(initcap(firstname)) AS first_name,
        TRIM(initcap(lastname)) AS last_name,
        TRIM(gender) AS gender,
        {{ cast_column_to(
            'birthdate',
            'DATE'
        ) }} AS birth_date,
        TRIM(emailaddress) AS email_address,
        {{ cast_column_to(
            'annualincome',
            'NUMERIC'
        ) }} AS annual_income,
        TRIM(maritalstatus) AS marital_status,
        {{ cast_column_to(
            'totalchildren',
            'INT'
        ) }} AS total_children,
        TRIM(homeowner) AS is_homeowner,
        TRIM(educationlevel) AS education_level,
        TRIM(occupation) AS occupation
    FROM
        src_customers
)
SELECT
    *
FROM
    stg_customers
