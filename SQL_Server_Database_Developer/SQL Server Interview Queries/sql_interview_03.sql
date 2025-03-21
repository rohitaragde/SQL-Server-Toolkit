----- SQL Interview Question 03---------------------------------


select * from emptesting;

select max(salary) as "secondhighestsal"
from emptesting
where salary<(select max(salary) from emptesting)

with ranked_salaries as
( select salary,
  rank() over(order by salary desc) as ranked_salaries
  from emptesting)

  select salary from ranked_salaries
  where ranked_salaries<=5;


 
  
