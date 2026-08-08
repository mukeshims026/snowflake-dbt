{{ config(
    schema='SILVER'
) }}

select 
    o.orderid       as order_id,
    o.orderdate     as order_date,
    c.cust_id       as customer_id,
    i.item_id       as item_id,
    o.quantity      as quantity,
    o.rate          as rate
from {{ ref('orders') }} o
left join {{ ref('dim_customer') }} c
    on o.customerid = c.cust_id
left join {{ ref('dim_item') }} i
    on o.itemid = i.item_id
