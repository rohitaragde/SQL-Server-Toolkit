------------------------------ David Frietag SQL Cheatsheeet---------------------------------------

create table offices
(id int primary key,
city varchar(10),
country varchar(12),
num_employees int,
date_opened date);

select * from offices;

------- Basic Querying--------------------

----- Ony select id and city columns-----------
select id,city from offices;

---- Renaming column id as office_id---------------
select id as office_id ,city from offices;

----- Selecting only top 3 records --------------------
select top 3* from offices;

-------------------------- Using where for filtering --------------------------------------------

---- Basic where--------------------------
select city,num_employees from offices
where num_employees>100;

---- where to find records between range----------

select city,num_employees 
from offices 
where num_employees between 50 and 100;

------------------------------ Using where and logical operators --------------------------------------

--- String matching ---
select country,num_employees
from offices 
where city like 'New York';

---- In Operator -----

select country,num_employees
from offices 
where city in ('New York','London');

---- is null and is not null -----

select country, num_employees 
from offices 
where num_employees is not null;

----------------- Combining Operators ------------------------------------

select city,num_employees
from offices 
where num_employees > 100
and country='United States';

select city,country from offices
where country='United States'
or country='United Kingdom';

select city,country
from offices
where country not in ('United States');

select city,country 
from offices 
where num_employees>50 
and (country='United States' or country='Czech Republic');

--------------------------------- Wildcards and Order By---------------------------------------------

select city,country,
num_employees from offices 
where country like 'United%';

select city,country,num_employees 
from offices 
order by num_employees desc;

------------------------------------ Grouping and Aggregating Data --------------------------------------

select country,
avg(num_employees) as avg_emp
from offices 
group by country;

select country,
min(num_employees) as min_emp,
max(num_employees) as max_emp,
sum(num_employees) as sum_emp,
avg(num_employees) as avg_emp
from offices 
group by country;

select country,count(*) as cnt_offices 
from offices group by country;

select country,count(*) as cnt_offices 
from offices 
group by country 
having count(*)>1;

---------------------------------------- Case When statements -------------------------------------


select 
case when country='United States' then 'USA'
     else country 
end as country_short
from offices;

select 
sum(case when num_employees>100 then 1 else 0 end) as sum_offices_100_plus 
from offices;

-------------------------------------- Distinct for unique values -------------------------------

select distinct country from offices;

-------------------------------------- SQL Joins --------------------------------------------------
select o.country,
o.city,
e.employee_name 
from offices o inner join employeesn as e
on o.id=e.emp_id;

select * from offices;
select * from employeesn;

select o.country,
o.city,
e.employee_name 
from offices o left join employeesn as e
on o.id=e.emp_id
and o.country='United States';

---------------------- Stack Results with Union All -----------------------------------------

select distinct city from offices 
union all
select distinct country from offices 

----------------------- CTEs and Subqueries ------------------------------------------------------

with unique_cities as
( select distinct city from offices )

select * from unique_cities;

select distinct city from offices where
city not in (select city from offices where num_employees>100);

------------------------------- Manipulating Data-------------------------------------------------

select distinct
upper(city) as uppercase_city,
lower(country) as lowercase_country,
substring(city,1,3) as first_3_city_name
from offices;

select concat(city, ',', country) as comb_city_country
from offices;

select year(date_opened)  as yr_opened
from offices;

select city,len(city) as city_length
from offices;

select num_employees,coalesce(num_employees,0) as non_null_num_employees
from offices;

------------------------------------- Window Functions --------------------------------------------

select distinct country,
sum(num_employees) over(partition by country) as num_emp_in_country
from offices;

select distinct country,
first_value(num_employees) over(partition by country order by date_opened) as num_first
from offices;

select country,city,date_opened,
rank() over(order by date_opened) as rank_num,
dense_rank() over(order by date_opened) as dense_rank_num,
row_number() over(order by date_opened) as row_num
from offices 
order by date_opened;

select * from offices;






update offices
set date_opened='2019-09-18'
where id=6;





























