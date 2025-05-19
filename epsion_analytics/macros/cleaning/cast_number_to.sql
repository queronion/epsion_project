-- A macro that converts a column to a specified type using try_cast.
-- It trims the column value before casting to ensure no leading or trailing spaces affect the conversion.

{% macro cast_column_to(column_name, cast_type) %}
    try_cast(trim({{ column_name }}) AS {{ cast_type }})
{% endmacro %}
