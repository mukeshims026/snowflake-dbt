{{ config(
    schema='GOLD',
    materialized='dynamic_table',
    target_lag='5 minutes',
    snowflake_warehouse='COMPUTE_WH'
) }}

select CI.COUNTRY,
       sum(O.QUANTITY * O.RATE) as sale
from {{ ref('fact_order') }} O
join {{ ref('dim_customer')}} C on O.CUSTOMER_ID = C.CUST_ID
join {{ ref('dim_cust_address')}} CA on C.CUST_ID = CA.CUST_ID
join {{ ref('dim_city') }} CI on CA.CITY = CI.CITY
group by CI.COUNTRY
