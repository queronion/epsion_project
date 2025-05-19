-- This macro cleans the binary flag values in two columns (is_homeowner and is_parent).
-- It takes the column name as input and returns a standardized value based on the input (Yes, No).
-- The macro uses the `trim` and `lower` functions to ensure consistent formatting and case-insensitive comparison. 

{% macro clean_binary_flag(column_name) %}

    case 
        when lower({{ column_name }}) in ('yes', 'y', 'true', '1') then 'Yes'
        when lower({{ column_name }}) in ('no', 'n', 'false', '0') then 'No'
        else 'Unknown'
    end


{% endmacro %}