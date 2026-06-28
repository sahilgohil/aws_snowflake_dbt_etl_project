-- macros/build_obt.sql
{% macro build_obt(config_name='obt_config') %}

  {% set config_vars = var(config_name) %}
  {% set base_model = config_vars['base_model'] %}
  {% set joins = config_vars['joins'] %}

  {# Retrieve base table columns dynamically #}
  {% set base_relation = ref(base_model) %}
  {% set base_columns = adapter.get_columns_in_relation(base_relation) %}

  with base as (
      select * from {{ base_relation }}
  ),

  {# Dynamically reference joined tables #}
  {% for join in joins %}
  {{ join.join_alias }} as (
      select * from {{ ref(join.join_model) }}
  ),
  {% endfor %}

  final as (
      select
          {# Include all columns from base model unmodified #}
          {% for col in base_columns %}
          base.{{ col.name }} as {{ col.name }}{{ "," if not loop.last or (joins | length > 0) }}
          {% endfor %}

          {# Include columns from joined models, prefixed to prevent name collisions #}
          {% for join in joins %}
              {% set join_relation = ref(join.join_model) %}
              {% set join_columns = adapter.get_columns_in_relation(join_relation) %}
              {% set outer_loop = loop %}
              
              {% for col in join_columns %}
              {{ join.join_alias }}.{{ col.name }} as {{ join.join_alias }}_{{ col.name }}{{ "," if not (outer_loop.last and loop.last) }}
              {% endfor %}
          {% endfor %}

      from base
      {% for join in joins %}
      {{ join.join_type }} join {{ join.join_alias }}
          on {{ join.join_on }}
      {% endfor %}
  )

  select * from final

{% endmacro %}