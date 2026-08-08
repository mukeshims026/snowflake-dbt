{% snapshot cust_city_hist %}

{{
    config(
      target_schema='SILVER',
      unique_key='cust_id',
      strategy='check',
      check_cols=['city']
    )
}}

select distinct
    cust_id,
    city
from {{ ref('dim_cust_address') }}

{% endsnapshot %}