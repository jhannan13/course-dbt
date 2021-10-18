with promos_source as (
  select * from {{ source('src_public', 'promos') }}
)

, renamed_casted as (
  select
    id as promo_id
    , promo_id as promo_desc
    , discout as discount
    , status as promo_status
  from promos_source
)

select * from renamed_casted