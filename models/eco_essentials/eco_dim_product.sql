{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
)}}

select
    {{ dbt_utils.generate_surrogate_key(['PRODUCT_ID']) }} as product_key,
    PRODUCT_ID as product_id,
    PRODUCT_NAME as product_name,
    PRODUCT_TYPE as product_type,
    PRICE as price
from {{ source('ecoessentials_landing', 'product') }}