### How many users do we have? 
```sql
select 
  count(distinct user_id) 
from dbt.dbt_jhannan.stg_users;
```
```
-------
   130
(1 row)
```
### On average, how many orders do we receive per hour?
```sql
with hourly_orders as (
  select
    date_trunc('hour', created_at_utc) as hour_ordered
    , count(distinct order_guid) as orders
    from dbt.dbt_jhannan.stg_orders
    group by 1
)

select avg(orders)
from hourly_orders;
```
```
        avg         
--------------------
 8.1632653061224490
(1 row)
```
### On average, how long does an order take from being placed to being delivered?
```sql
with order_deliveries as (
  select
   order_guid
   , (date_part('day', delivered_at_utc::timestamp - created_at_utc::timestamp) * 24 + 
               date_part('hour', delivered_at_utc::timestamp - created_at_utc::timestamp)) * 60 +
               date_part('minute', delivered_at_utc::timestamp - created_at_utc::timestamp) as delivery_time
   from dbt.dbt_jhannan.stg_orders
)
select avg(delivery_time) as avg_delivery_time_minutes
from order_deliveries;
```
```
        avg        
-------------------
 5653.175074183976
(1 row)
```
### How many users have only made one purchase? Two purchases? Three+ purchases? 
### On average, how many unique sessions do we have per hour?
