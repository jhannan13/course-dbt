with orders_source as (
  select * from {{ source('src_public', 'orders') }}
)

, renamed_casted as (
  select
    id as order_id
    , order_id as order_guid
    , user_id as user_guid
    , order_cost
    , shipping_cost
    , order_total as order_total_cost
    , status as order_status
    , promo_id::varchar as promo_desc
    , created_at as created_at_utc
    , estimated_delivery_at as estimated_delivery_at_utc
    , delivered_at as delivered_at_utc
  from orders_source
)

select * from renamed_casted