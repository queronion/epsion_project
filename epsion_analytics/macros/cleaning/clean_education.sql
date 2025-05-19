-- This macro is to clean the education level of a customer.
-- It takes the education_level column as input and returns a standardized value based on the input.
-- The macro uses the `trim` function to remove any leading or trailing spaces from the input.
-- It also uses the `case` statement to check for specific values and return a standardized value.

{% macro clean_education(education_level) %}

    case 
        when trim(lower({{ education_level }})) in ('high school', 'hs') then 'High School'
        when trim(lower({{ education_level }})) in ('bachelor', 'bachelors', 'bachelor degree', 'bachelor''s') then 'Bachelor'
        when trim(lower({{ education_level }})) in ('master', 'graduate', 'graduate degree', 'masters', 'master degree', 'master''s') then 'Master'
        when trim(lower({{ education_level }})) in ('phd', 'ph.d', 'p.hd') then 'PHD'
        else education_level
    end

{% endmacro %}