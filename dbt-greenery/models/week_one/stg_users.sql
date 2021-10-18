with users_source as (
  select * from {{ source('src_public', 'users') }}
)

, renamed_casted as (
  select
    id
    , user_id
    , address_id
    , first_name
    , last_name
    , email
    , phone_number
    , created_at as created_at_utc
    , updated_at as updated_at_utc
  from users_source
)

select * from renamed_casted