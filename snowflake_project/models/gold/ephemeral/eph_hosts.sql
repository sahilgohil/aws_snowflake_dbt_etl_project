{{
  config(
    materialized = 'ephemeral',
    )
}}

with hosts as(
    select host_host_id as host_id,
            host_host_since as host_since,
            host_is_superhost as is_superhost,
            HOST_RESPONSE_RATE_QUALITY as response_rate_quality,
            host_created_at as created_at
    from {{ ref('obt') }}
)

select *
from hosts