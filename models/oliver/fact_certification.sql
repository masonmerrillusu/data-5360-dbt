{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    e.employee_key,
    d.date_key,
    stg.certification_name,
    stg.certification_cost
from {{ ref('stg_employee_certifications') }} stg
inner join {{ ref('oliver_dim_employee') }} e
    on stg.employee_id = e.employee_id
inner join {{ ref('oliver_dim_date') }} d
    on stg.certification_awarded_date = d.date_key