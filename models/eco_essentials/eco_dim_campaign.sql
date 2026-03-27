{{ config(
    materialized='table', 
    schema='dw_ecoessentials'
)}}

with source_data as (
    select * from {{ source('ecoessentials_landing', 'promotional_campaign') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['campaign_id']) }} as campaign_key,
    
    campaign_id,
    campaign_name,
    campaign_discount

from source_data