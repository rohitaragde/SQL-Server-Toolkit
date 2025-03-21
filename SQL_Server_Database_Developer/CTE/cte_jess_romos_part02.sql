/*

 Pull a list of all the shopping transactions where the purchase_amount_usd is less than the 
 state's (location) average purchase amount. Include the following columns:

Customer_ID
Location
purchase_amount_usd
state_avg (you have to make this one!)
diff_from_avg (you have to make this one!)
Hint: Find the purchase amount averages by state first and save them as a CTE. Then calculate the rest below.

*/

select top 10* from dbo.shopping_trends;


with state_averages as
(
select location,avg(purchase_amount_usd) as state_avg from TUT..shopping_trends
group by location)

select trends.customer_id, trends.location,trends.purchase_amount_usd,
avgs.state_avg,trends.purchase_amount_usd-avgs.state_avg as diff_from_avg
from shopping_trends trends join state_averages avgs
on trends.location=avgs.location
where trends.purchase_amount_usd<avgs.state_avg;



