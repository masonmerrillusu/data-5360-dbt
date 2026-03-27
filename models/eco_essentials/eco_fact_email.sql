{{ config(
    materialized = 'table', schema = 'dw_ecoessentials'
)}}

with staging as (
    select * from {{ ref('stg_marketing_emails') }}
),

customers as ( select * from {{ ref('eco_dim_customer') }} ),
events as ( select * from {{ ref('eco_dim_event') }} ),
dates as ( select * from {{ ref('eco_dim_date') }} ),
campaigns as ( select * from {{ ref('eco_dim_campaign') }} )

select
    {{ dbt_utils.generate_surrogate_key(['s.email', 's.interaction_timestamp', 's.event_name']) }} as email_event_key,
    
    cust.customer_key as customer_key,
    e.event_key       as event_key,
    d.date_key        as date_key,
    camp.campaign_key as campaign_key

from staging s
join customers cust on s.email = cust.email
join events e on s.event_name = e.event_type
join dates d on cast(s.interaction_timestamp as date) = d.date_key
left join campaigns camp on s.campaign_id = camp.campaign_id