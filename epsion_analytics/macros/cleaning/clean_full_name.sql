-- This macro returns the full name of a customer by concatenating the prefix, first name, and last name.
-- It uses the `concat_ws` function to concatenate the strings with a space as the separator, and `initcap` to capitalize each part of the name.
-- The `trim` function is used to remove any leading or trailing spaces from each part of the name.

{% macro clean_full_name(prefix, first_name, last_name )%}

    concat_ws(
        ' ',
        prefix,
        first_name,
        last_name
    )

{% endmacro %}