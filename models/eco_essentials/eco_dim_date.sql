{{ config(
    materialized='table', schema='dw_ecoessentials'
)}}

with cte_date as (
    {{ dbt_date.get_date_dimension("2024-01-01", "2026-12-31") }}
)

select
    date_day as date_key,
    year_number as year,
    quarter_of_year as quarter,
    month_of_year as month,
    day_of_month as day,
    day_of_week_name as day_of_week
from cte_date