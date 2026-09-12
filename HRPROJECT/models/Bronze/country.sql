{{
    config(
        materialized= 'table',
        schema='BRONZE',
        on_schema_change='sync_all_columns'
    )
}}

select
    COUNTRYID,COUNTRYNAME,ISCCODE,CAPITAL
from {{ source('rawseed', 'country_raw') }}