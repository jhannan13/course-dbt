with events_source as (
  select * from {{ source('src_public', 'events') }}
)

, renamed_casted as (
  select
    id as event_id
    , event_id as event_guid
    , session_id as session_guid
    , user_id as user_guid
    , event_type
    , page_url
    , created_at as created_at_utc
  from events_source
)

select * from renamed_casted