---- lag(), lead()----------------------

select * from TUT..employee

select name,gender,salary,
lead(salary,2,-1) over(partition by gender order by salary) as lead
from TUT..employee