-- This macro cleans the gender values in the customer data.
-- It takes gender as input and returns a standardized value based on the input

{% macro clean_gender(gender) %}

    case 
        when lower({{ gender }}) in ('male', 'm') then 'Male'
        when lower({{ gender }}) in ('female', 'f') then 'Female'
        else 'Undefined'
    end

{% endmacro %}