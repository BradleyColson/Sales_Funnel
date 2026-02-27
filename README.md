# Sales_Funnel
Sales Funnel Analysis

#Used SQL to find the sales funnel and see how effective it is.  Showing an overall 92% payment to purchase rate. This is excellent.

31% views to cart is low. Data showing a high amount of window shopping potentionally.

#Funneling by traffic source.  

stage_1_views, stage_2_cart, view_to_cart_rate, stage_3_checkout, cart_to_checkout_rate, stage_4_payment, checkout_to_payment_rate, stage_5_purchase, payment_to_purchase_rate, overall_conversion_rate
4985	         1547	         31	                 1100	            71	                   896	             81	                       824	             92	                       17

Email conversion rate being 62% is excellent.  Social media is only convering 14%. Email has the lowest views but as stated it coverts the best.

traffic_source, views, carts, purchases, cart_conversion_rate, purchase_conversion_rate, cart_to_purchase_conversion_rate
organic	        2029	        664	       341	 33	             17	                        51
paid_ads	      966	          358	       204	 37	             21	                        57
email	          522	          326	       177	 62	             34	                        54
social	        1468	        199	       102	 14	              7	                        51

#SQL Sales Funnel Revenue

total_visitors, total_buyers, total_revenue, total_orders, avg_order_value, revenue_per_buyer, revenue_per_visitor
4985	          824	           87746.54	      824	          106.49	         106.49	             17.6


1. Checkout Design
The Conversion rates from Checkout to Purchase are excellent at 0%
  Action: Do not redesign the checkout page right now, you risk breaking something that is working.

2. Marketing
Stop over investing in Social for Sales. Social Media is driving 30% of the traffic but has the lowest conversion rate. We're paying for window shopping.
  Action: Shift budget away from Traffic objectives on social media ads and focus on retargeting to capture emails instead.

Double down on email marketing. Email is the highest converting channel 13% vs 6% for social.
  Action: Implement an agressive email capture pop up for high volume social visitors.If they can be captured via email, the data proves they are more likely to buy later.

3. Financial Revenue

Average order value is $106.
Action: Set a strict customer acquisition cost limit. If we are paying more than $30-40 to acquire a customer via social media ads , which converted poorly, we are likely losiong money on those transactions.
