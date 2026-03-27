{{ config(
    materialized = 'table', schema = 'dw_ecoessentials'
)}}

with order_lines as (
    select * from {{ source('ecoessentials_landing', 'order_line') }}
),
orders as (
    select * from {{ source('ecoessentials_landing', 'order') }}
),

customers as ( select * from {{ ref('eco_dim_customer') }} ),
products as ( select * from {{ ref('eco_dim_product') }} ),
dates as ( select * from {{ ref('eco_dim_date') }} ),
campaigns as ( select * from {{ ref('eco_dim_campaign') }} )

select
    {{ dbt_utils.generate_surrogate_key(['ol.order_line_id']) }} as order_line_key,

    cust.customer_key as customer_key,
    p.product_key     as product_key,
    d.date_key        as date_key,
    camp.campaign_key as campaign_key,
    
    cast(o.order_timestamp as time) as time_key,

    o.order_id as order_id, 

    p.price                as unit_price,
    ol.quantity            as quantity,
    ol.discount            as discount,
    ol.price_after_discount as price_after_discount,

    (ol.quantity * ol.price_after_discount) as revenue

from order_lines ol
join orders o on ol.order_id = o.order_id
join customers cust on o.customer_id = cust.customer_id
join products p on ol.product_id = p.product_id
join dates d on cast(o.order_timestamp as date) = d.date_key
left join campaigns camp on ol.campaign_id = camp.campaign_id