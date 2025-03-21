------------------------------- Sample Interview Questions---------------------------------------
select * from EmployeeTbl

select * from DepartmentTbl

---Q1-> Return employee record with max salary
select * from EmployeeTbl where salary=(select max(salary) from EmployeeTbl)

---Q2)-> Select highest salary in the employee table
select max(salary) as "highestsalary" from EmployeeTbl

---Q3-> select the 2nd highest salary in the employee table

select * from EmployeeTbl

with cte as
(
select *,
rank() over(order by salary desc) as rn
from EmployeeTbl)

select * from cte where rn=2

select max(salary) as highestsalary from EmployeeTbl
where salary<( select max(salary) from EmployeeTbl)

--- Q4)->  select range of employees based on ID

select * from EmployeeTbl where employee_id between 2003 and 2008

---- Q5)-> return employee name , highest salary and department

select e.first_name,e.last_name,e.salary,d.department_name
from EmployeeTbl e inner join DepartmentTbl d
on e.department_id=d.department_id
where salary in(select max(salary) from EmployeeTbl)


----- Q6)-> select highest salary, employee name, department name for each department

select e.first_name,e.last_name,max(e.salary),d.department_name
from EmployeeTbl e inner join DepartmentTbl d
on e.department_id=d.department_id
group by e.first_name,e.last_name,d.department_name


