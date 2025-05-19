-- This model is used to create a dimension table for dates in the MARTS schema with the name dim_dates.
-- The model is materialized as a table and includes various date attributes such as year, quarter, month, day, and weekend status. 
-- The date range is defined from a start date of '2023-01-01' to one year from the current date.

{{ config(
    materialized='table',
    schema='MARTS',
    alias='dim_dates'
) }}

-- min date in the data 
WITH start_date AS (
    SELECT date '2023-01-01' AS date_day
),
-- max date (updates automatically)
end_date AS (
    SELECT current_date + interval '1 year' AS date_day  -- Fixed interval syntax
),
date_spine AS (
    SELECT 
        date_day
    FROM start_date
    UNION ALL
    SELECT 
        date_day + interval '1 day'  -- Fixed interval syntax
    FROM date_spine
    WHERE date_day + interval '1 day' <= (SELECT date_day FROM end_date)
)
SELECT 
    date_day AS date,
    EXTRACT(YEAR FROM date_day) AS year,
    EXTRACT(QUARTER FROM date_day) AS quarter,
    EXTRACT(MONTH FROM date_day) AS month,
    TO_CHAR(date_day, 'YYYY-MM') AS year_month,
    TO_CHAR(date_day, 'Mon') AS month_name,
    EXTRACT(DAY FROM date_day) AS day,
    EXTRACT(dow FROM date_day) AS day_of_week, -- 0 = Sunday in Snowflake
    to_char(date_day, 'DY') AS day_name,
    CASE 
        WHEN EXTRACT(dow FROM date_day) IN (0, 6) THEN 'Yes' 
        ELSE 'No'
    END AS is_weekend
FROM date_spine
ORDER BY date
