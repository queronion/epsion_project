-- This macro is to clean the marital status of a customer.
-- It takes the martial_status column as input and returns a standardized value based on the input (S, M).
-- The macro uses the `lower` function to convert the input to lowercase for case-insensitive comparison.

{% macro clean_marital_status(marital_status) %}


    case 
        when lower({{ marital_status }}) in ('single', 's') then 'Single'
        when lower({{ marital_status }}) in ('married', 'm') then 'Married'
        else 'Unknown'
    end

{% endmacro %}