with products_source as (
  select * from {{ source('src_public', 'products') }}
)

, renamed_casted as (
  select
    id as product_id
    , product_id as product_guid
    , name as product_name
    , price
    , quantity as product_quantity
  from products_source
)

select * from renamed_casted