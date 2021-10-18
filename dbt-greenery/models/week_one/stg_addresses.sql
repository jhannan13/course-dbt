with addresses_source as (
  select * from {{ source('src_public', 'addresses') }}
)

, renamed_casted as (
  select
    id as address_id
    , address_id as address_guid
    , address as street_address
    , zipcode as zip_code
    , state
    , country
  from addresses_source
)

select * from renamed_casted