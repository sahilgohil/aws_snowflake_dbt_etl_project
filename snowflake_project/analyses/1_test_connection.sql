select *
from {{ source('snowflake_staging', 'hosts') }}