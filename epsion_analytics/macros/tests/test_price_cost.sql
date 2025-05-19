-- Created this generic test to check if the price is greater than the cost
-- This test is used to ensure that the price is greater than the cost

{% test test_price_cost(model, column_name, test_column) %}

SELECT *
FROM {{ model }}
WHERE {{ column_name }} < {{ test_column }}

{% endtest %}
