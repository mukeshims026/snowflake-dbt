{{ config(schema='SILVER') }}

select 
    row_number() over (order by city, country) as id,
    city,
    country
from (
    select 
        distinct
        city,
        country
    from {{ ref('orders')}}
    )