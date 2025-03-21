----------------ROLLING CALCULATIONS SUM,AVG,MIN,MAX----------------------------

select * from TUT..superstore_orders$

with year_month_sales as
(
select datepart(year,order_date) as year_order,
	   datepart(month,order_date) as month_order,
	   sum(sales) as "tsales"
	   from TUT..superstore_orders$
	   group by datepart(year,order_date),datepart(month,order_date)
)

select *,
sum(tsales) over(order by year_order asc,month_order asc rows between 1 preceding and 1 following) as rolling_3_sum,
avg(tsales) over(order by year_order asc,month_order asc rows between 1 preceding and 1 following) as average_3_sum,
max(tsales) over(order by year_order asc,month_order asc rows between 1 preceding and 1 following) as max_3_sum,
min(tsales) over(order by year_order asc,month_order asc rows between 1 preceding and 1 following) as min_3_sum
from year_month_sales




select * from year_month_sales
