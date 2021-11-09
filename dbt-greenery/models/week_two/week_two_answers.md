### What is our user repeat rate?
```sql
with orders_cohort as (
  select
    user_guid
    , count(distinct order_guid) as user_orders
  from dbt.dbt_jhannan.stg_orders
  group by 1
)
, users_bucket as (
  select 
    user_guid
    , (user_orders = 1)::int as has_one_purchases
    , (user_orders = 2)::int as has_two_purchases
    , (user_orders >= 3)::int as has_three_purchases
  from orders_cohort
)

select
  sum(has_two_purchases)::float / count(distinct user_guid)::float as repeat_rate
from users_bucket;
```
```
 repeat_rate 
-------------
    0.171875
(1 row)
```
### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
I would probably want to understand how users are getting to the site (e.g., marketing campaigns, SEO) and then more event detail around products being viewed on site. Understanding where users are spending most of their time and what products are being presented to them would be super helpful to find purchasing patterns.