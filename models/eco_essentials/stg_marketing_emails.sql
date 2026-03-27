{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
)}}

select
    subscriberid as subscriber_id, 
    subscriberfirstname as first_name,
    subscriberlastname as last_name,
    subscriberemail as email, 
    eventtype as event_name, 
    eventtimestamp as interaction_timestamp, 
    campaignid as campaign_id
from {{ source('s3_landing_marketingemails', 'marketingemails') }}