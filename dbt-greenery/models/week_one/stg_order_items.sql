with order_items_source as (
  select * from {{ source('src_public', 'order_items') }}
)

, renamed_casted as (
  select
    id as order_item_id
    , order_id as order_guid
    , product_id as product_guid
    , quantity as order_quantity
  from order_items_source
)

select * from renamed_casted