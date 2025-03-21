select top 10* from dbo.shopping_trends;

/*Q1) What is the average revenue per year?
Hint: you’ll need to add up all the sellingprices for each year and then 
take the average across all the years.*/

select location,avg(purchase_amount_usd) as state_avg from TUT..shopping_trends
group by location;

with state_averages as
(
select location,avg(purchase_amount_usd) as state_avg from TUT..shopping_trends
group by location)

select min(state_avg) as min_state_avg,
max(state_avg) as max_state_avg,
stdev(state_avg) as stddev_state_avg
from state_averages;


