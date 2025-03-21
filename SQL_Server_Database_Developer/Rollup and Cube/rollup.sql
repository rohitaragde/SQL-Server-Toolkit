----------rollup()--------------------------

create table EmpNewTest
(id int primary key,
Name varchar(10),
gender varchar(10),
salary int,
country varchar(10));

select * from EmpNewTest

select country,gender,sum(salary) as totalsalary
from EmpNewTest
group by country,gender

union all

select Country,NULL,sum(salary) as totalsalary
from EmpNewTest
group by country

union all

select NULL,NULL,sum(salary) as totalsalary
from EmpNewTest

select country,gender,sum(salary) as totalsalary
from EmpNewTest
group by grouping sets
( 
  (Country,Gender),
  (Country),
  ()

)


select country,gender,sum(salary) as totalsalary
from EmpNewTest
group by rollup(country,gender)

select country,gender,sum(salary) as totalsalary
from EmpNewTest
group by country,gender with rollup

