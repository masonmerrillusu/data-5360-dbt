{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
)}}

select distinct
    {{ dbt_utils.generate_surrogate_key(['event_name']) }} as event_key,
    event_name as event_type
from {{ ref('stg_marketing_emails') }}