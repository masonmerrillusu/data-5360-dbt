{{ config(
    materialized='table', schema='dw_ecoessentials'
)}}

with db_customer as (
    select * from {{ source('ecoessentials_landing', 'customer') }}
),
s3_subscriber as (
    select * from {{ ref('stg_marketing_emails') }}
),
final as (
    select
        db.customer_id,
        s3.subscriber_id,
        case when db.customer_first_name is not null then db.customer_first_name else s3.first_name end as first_name,
        case when db.customer_last_name is not null then db.customer_last_name else s3.last_name end as last_name,
        case when db.customer_email is not null then db.customer_email else s3.email end as email,
        db.customer_phone as phone,
        db.customer_address as address,
        db.customer_city as city,
        db.customer_state as state,
        db.customer_zip as zip,
        db.customer_country as country
    from db_customer db
    full outer join s3_subscriber s3 on db.customer_email = s3.email
)
select
    {{ dbt_utils.generate_surrogate_key(['email']) }} as customer_key,
    *
from final