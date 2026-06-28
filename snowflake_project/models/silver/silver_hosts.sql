select 
    *,
    case when response_rate > 95 then 'Very Good'
        when response_rate > 80 then 'Good'
        when response_rate > 60 then 'Fair'
        else 'Poor'
    end as response_rate_quality
from {{ ref('bronze_hosts') }}

{% if is_incremental() %}
  where CREATED_AT > (select coalesce(max(CREATED_AT), '1900-01-01') from {{ this }})
{% endif %}
