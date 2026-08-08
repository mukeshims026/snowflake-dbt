{{ config(schema='SILVER') }}
select 
    item_id,
    item_name
from 
(
    select  distinct 
        itemid as item_id, 
        itemname as item_name
    from 
        {{ ref('orders')}}
)