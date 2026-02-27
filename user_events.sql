select *
from user_events;

-- Define sales funnel and different stages

with funnel_stages as (
select
	count(distinct  case when event_type = "page_view" then user_id end) as stage_1_views,
	count(distinct  case when event_type = "add_to_cart" then user_id end) as stage_2_cart,
	count(distinct  case when event_type = "checkout_start" then user_id end) as stage_3_checkout,
	count(distinct  case when event_type = "payment_info" then user_id end) as stage_4_payment,
	count(distinct  case when event_type = "purchase" then user_id end) as stage_5_purchase

from user_events2
where event_date >= timestamp(date_sub(current_date(), interval 30 day))
)



-- Conversion rate using same cte

select 
stage_1_views,
stage_2_cart,
round(stage_2_cart * 100 / stage_1_views) as view_to_cart_rate,
stage_3_checkout,
round(stage_3_checkout * 100 / stage_2_cart) as cart_to_checkout_rate,
stage_4_payment,
round(stage_4_payment * 100 / stage_3_checkout) as checkout_to_payment_rate,

stage_5_purchase,
round(stage_5_purchase * 100 / stage_4_payment) as payment_to_purchase_rate,

round(stage_5_purchase * 100 / stage_1_views) as overall_conversion_rate

from funnel_stages;

-- Funnel by source

with source_funnel as (
Select
traffic_source,
	count(distinct  case when event_type = "page_view" then user_id end) as views,
	count(distinct  case when event_type = "add_to_cart" then user_id end) as carts,
	count(distinct  case when event_type = "purchase" then user_id end) as purchases

from user_events2
where event_date >= timestamp(date_sub(current_date(), interval 30 day))
group by traffic_source
)

select 
traffic_source,
views,
carts,
purchases,
round(carts * 100 / views) as cart_conversion_rate,

round(purchases * 100 / views) as purchase_conversion_rate,

round(purchases * 100 / carts) as cart_to_purchase_conversion_rate

from source_funnel
order by purchases desc;

-- time to conversion analysis

with user_journey as (
select 
user_id,
	min(case when event_type = "page_view" then event_date end) as views_time,
	min(case when event_type = "add_to_cart" then event_date end) as cart_time,
	min(case when event_type = "purchase" then event_date end) as purchases_time
    
from user_events2

where event_date >= timestamp(date_sub(current_date(), interval 30 day))
group by user_id
having min(case when event_type = "purchase" then event_date end) is not null
)

select
count(*) as converted_users,
round(avg(timestampdiff(cart_time, view_time, minute)),2) as avg_cart_to_view_minutes,
round(avg(timestampdiff(purchase_time, cart_timme, minute)),2) as avg_cart_to_purchase_minutes,
round(avg(timestampdiff(purchase_time, view_time, minute)),2) as avg_total_journey_minutes

from user_journey;

--

WITH user_journey AS (
  SELECT 
    user_id,
    MIN(CASE WHEN event_type = 'page_view' THEN event_date END) AS views_time,
    MIN(CASE WHEN event_type = 'add_to_cart' THEN event_date END) AS cart_time,
    MIN(CASE WHEN event_type = 'purchase' THEN event_date END) AS purchases_time
  FROM user_events2
  -- MySQL uses DATE_SUB differently than BigQuery
  WHERE event_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
  GROUP BY user_id
  HAVING purchases_time IS NOT NULL
)

SELECT
  COUNT(*) AS converted_users,
  ROUND(AVG(TIMESTAMPDIFF(MINUTE, views_time, cart_time)), 2) AS avg_view_to_cart_minutes,
  ROUND(AVG(TIMESTAMPDIFF(MINUTE, cart_time, purchases_time)), 2) AS avg_cart_to_purchase_minutes,
  ROUND(AVG(TIMESTAMPDIFF(MINUTE, views_time, purchases_time)), 2) AS avg_total_journey_minutes
FROM user_journey;

---------------------------------------------
-- sales funnel revenue
with funnel_revenue as (

select

count(distinct case when event_type = "page_view" then user_id end) as total_visitors,
count(distinct case when event_type = "purchase" then user_id end) as total_buyers,
sum(case when event_type = "purchase" then amount end) as total_revenue,
count(case when event_type = "purchase" then user_id end) as total_orders

from user_events2

where event_date >= timestamp(date_sub(current_date(), interval 30 day))
)
select
total_visitors,
total_buyers,
total_revenue,
total_orders,
total_revenue / total_orders as avg_order_value,
total_revenue / total_buyers as revunue_per_buyer,
total_revenue / total_visitors as revenue_per_visitor

from funnel_revenue;


