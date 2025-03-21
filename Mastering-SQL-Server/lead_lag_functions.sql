----------------------- LEAD/LAG functions -------------------------------------
/* The LAG function has the ability to fetch data from a previous row, 
while LEAD fetches data from a subsequent row.
Both functions are very similar to each other and you can just 
replace one by the other by changing
the sort order.*/


select * from dbo.orders;

with year_sales as
(select region,datepart(year,order_date) as order_year,
 sum(sales) as sales from orders 
 group by region,DATEPART(year,order_date))
 

 select *,
 lag(sales,1,0) over(partition by region order by order_year) as prev_yr_sales,
 lead(sales,1,0) over(partition by region order by order_year) as next_yr_sales,
 sales-lag(sales,1,0) over(order by order_year) as diference
 from year_sales
 order by region,order_year






 


