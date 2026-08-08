{% macro generate_audit_column() %}
    , current_timestamp() as created_at
    , current_timestamp() as updated_at
    , current_user() as created_by
    , current_user() as updated_by
{% endmacro %}