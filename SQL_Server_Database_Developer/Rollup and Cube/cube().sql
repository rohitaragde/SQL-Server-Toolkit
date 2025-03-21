-----------------------cube()-------------------------------


select * from EmpNewTest

select country,gender,sum(salary) as totalsalary
from EmpNewTest
group by country,gender

select country,gender,sum(salary) as totalsalary
from EmpNewTest
group by cube(country,gender)

select country,gender,sum(salary) as totalsalary
from EmpNewTest
group by country,gender with cube

select country,gender,sum(salary) as totalsalary
from EmpNewTest
group by grouping sets
(
    (country,gender),
	(country),
	(gender),
	()

)

select country,gender,sum(salary) as totalsalary
from EmpNewTest
group by country,gender

union all

select country,null,sum(salary) as totalsalary
from EmpNewTest
group by country

union all

select null,gender,sum(salary) as totalsalary
from EmpNewTest
group by gender

union all

select null,null,sum(salary) as totalsalary
from EmpNewTest








