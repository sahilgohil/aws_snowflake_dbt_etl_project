{{
  config(
    materialized = 'ephemeral',
    )
}}

with listings as(
    select listing_id,
            LISTING_PROPERTY_TYPE as property_type,
            listing_room_type as room_type,
            listing_city as city,
            listing_country as country,
            listing_created_at as created_at
    from {{ ref('obt') }}
)

select *
from listings