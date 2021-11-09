{{
  config(
    materialized = 'table'
  )
}} 

with session_length as (
  select 
    session_guid
    , min(created_at_utc) as first_event
    , max(created_at_utc) as last_event
  from {{ ref('stg_events') }}
  group by 1
)

select
  session_events_agg.session_guid
  , session_events_agg.user_guid
  , stg_users.first_name
  , stg_users.last_name
  , stg_users.email
  , session_events_agg.page_view
  , session_events_agg.account_created
  , session_events_agg.add_to_cart
  , session_events_agg.delete_from_cart
  , session_events_agg.checkout
  , session_events_agg.package_shipped
  , session_length.first_event as first_session_event
  , session_length.last_event as last_session_event
  , (date_part('day', session_length.last_event::timestamp - session_length.first_event::timestamp) * 24 + 
      date_part('hour', session_length.last_event::timestamp - session_length.first_event::timestamp)) * 60 +
      date_part('minute', session_length.last_event::timestamp - session_length.first_event::timestamp)
    as session_length_minutes

from {{ ref('session_events_agg') }}
left join {{ ref('stg_users') }}
  on session_events_agg.user_guid = stg_users.user_guid
left join session_length
  on session_events_agg.session_guid = session_length.session_guid