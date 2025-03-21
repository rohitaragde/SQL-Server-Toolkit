----------------- SQL Interview Question 01---------------------------

create table sales_data
(category varchar(20),
amount int,
sale_date date);

drop table sales_data 

-- Retrieve the total sales for each category in the year 2022----------

select * from sales_data;

select category,sum(amount) as totalsales
from sales_data
where year(sale_date)=2022
group by category 


