------------------------ SQL Order Of Execution-----------------------

select top 5 employeeid,FirstName,LastName,salary,salary*1.0/2 as half_salary
from EmpTest
--where salary>540000
order by salary desc

select top 1 e.dept_id,d.dept_name,sum(salary) as dept_salary
from EmpTest e inner join departmentTest d
on e.dept_id=d.dept_id
where salary>540000
group by e.dept_id,d.dept_name
having sum(salary)>12000
order by dept_salary desc


select * from departmentTest


--from->join->where->group by->having->select-->order by-->top 5
-- In case of multiple joins the joins placed first executes
--and the second join builds on the results of the first join




select * from EmpTest



