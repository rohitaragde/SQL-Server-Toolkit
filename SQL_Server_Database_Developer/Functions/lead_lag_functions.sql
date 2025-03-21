---------------- LEAD/LAG FUNCTIONS-----------------------------------

select * from TUT..superstore_orders$

select top 5* from TUT..superstore_orders$

with year_sales as
(select region,datepart(year,order_date) as order_year,sum(sales) as sales
 from TUT..superstore_orders$ group by region,datepart(year,order_date))

select *, 
lag(sales,1,0) over(partition by region order by order_year) as prev_year_sales,
lead(sales,1,0) over(partition by region order by order_year) as next_year_sales
from year_sales 
order by region,order_year



