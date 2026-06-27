{% macro multiply(a, b, decimal) %}
    round({{a}} * {{b}}, {{decimal}})
{% endmacro %}