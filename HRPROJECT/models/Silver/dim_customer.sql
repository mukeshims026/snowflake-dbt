{{ config(schema='SILVER') }}

select 
    cust_id,
    cust_name
from
(
    select distinct 
        customerid as cust_id, 
        customername as cust_name
    from {{ ref('orders') }}
)