{{
  config(
    materialized = 'view',
    )
}}

with facts as(
    select booking_id,
            listing_id,
            listing_host_id as host_id,
            total_booking_amount,
            listing_accommodates as accommodates,
            listing_bedrooms as bedrooms,
            listing_bathrooms as bathrooms,
            listing_price_per_night as price_per_night,
            host_response_rate
    from {{ ref('obt') }}
)

select *
from facts