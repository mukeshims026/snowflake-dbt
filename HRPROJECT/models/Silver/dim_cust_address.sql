{{ config(
    materialized='table',
    schema='SILVER'
) }}

with ranked_orders as (
    select
        o.customerid,
        o.city,
        row_number() over (
            partition by o.customerid
            order by o.orderdate desc
        ) as rn
    from {{ ref('orders') }} o
)

select
    c.cust_id       as cust_id,
    ci.city         as city
from ranked_orders ro
join {{ ref('dim_customer') }} c
    on ro.customerid = c.cust_id
join {{ ref('dim_city') }} ci
    on ro.city = ci.city
where ro.rn = 1
