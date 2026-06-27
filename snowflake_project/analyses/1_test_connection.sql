select *
from {{ source('snowflake_staging', 'bookings') }}