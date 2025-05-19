-- This macro calculates the age in years from a given birth date.
-- It uses the DATEDIFF function to find the difference in days between the current date and the birth date,

{% macro calculate_age(birth_date)%}

    round(
        datediff(
            'day',
            {{ birth_date }},
            current_date
        ) / 365.25
    )

{% endmacro %}