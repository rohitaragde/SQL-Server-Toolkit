---------------- Difference between where and having clause -----------------------

/* where clause applies filter on each row and then returns the output*/
select * from emp
where salary>10000;

/* having clause is used to apply filter on groups of reasultset or
simple if you have to apply filter on any aggregated value then
we can use having clause*/

select department_id,avg(salary) as avgsalary
from emp
group by department_id
having avg(salary)>9500;

select department_id,avg(salary) as 'Department Average Salary'
from emp
where salary>10000
group by department_id
having avg(salary)>10000;









