/* SubQueries */

select * from EmployeeSalary;

-- SubQuery in Select

select employeeid,salary,(select avg(salary) from EmployeeSalary) as AllAvgSalary
from EmployeeSalary;

-- How to do it in partition By

select employeeid,salary,
avg(salary) over() as AvgSalary
from EmployeeSalary;

--- Why Group By does not work
select employeeid,salary,avg(salary) as AllAvgSalary
from EmployeeSalary
group by employeeid,salary 
order by 1,2;


----- SubQuery in From

select a.employeeid,AvgSalary from (select employeeid,salary,avg(salary) over() as AvgSalary from EmployeeSalary) a

--- ( Althogh subquery works here but we must always prefer temp tables or CTEs.
 ---    Temp tables are the best option as you just have to create them once and you can reuse them
---	 CTEs have to created and executed but better than subquery))

--- SubQuery in Where

select employeeid,jobtitle,salary from EmployeeSalary where employeeid in ( select * from EmployeeDemographics where age>30);

---- ( As you can see since select * returns all the rows and we can return only one value for the outer select since 
 ------ we are selecting the employeeid we have to modify it to "employeeid"))

 select employeeid,jobtitle,salary from EmployeeSalary where employeeid in ( select employeeid from EmployeeDemographics where age>26);

 --- ( You can see now it produced the appropriate results through subquery)

 ---- ( SUbqueries are mostly used in real world scenarios where you want immediate results)

 ------ ( If not like that you can always go for temp tables or CTEs)


