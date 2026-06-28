select 
    *,
    {{ tag('price_per_night') }} as price_per_night_tag
from {{ ref('bronze_listings') }}

{% if is_incremental() %}
  where CREATED_AT > (select coalesce(max(CREATED_AT), '1900-01-01') from {{ this }})
{% endif %}