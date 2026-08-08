{{
    config(
        materialized='incremental',
        unique_key='ORDERID',
        schema='BRONZE',
        on_schema_change='sync_all_columns'
    )
}}

select 
    ORDERID,ORDERDATE,CUSTOMERID,CUSTOMERNAME,ITEMID,ITEMNAME,QUANTITY,RATE,ADDRESS,CITY,COUNTRY
    {{ generate_audit_column() }}
from (
    select
        ORDERID,ORDERDATE,CUSTOMERID,CUSTOMERNAME,ITEMID,ITEMNAME,QUANTITY,RATE,ADDRESS,CITY,COUNTRY
    from {{ source('raw', 'order_raw') }}
)

{% if is_incremental() %}
  -- Only load rows not already in bronze.orders
  where ORDERID not in (select ORDERID from {{ this }})
{% endif %}