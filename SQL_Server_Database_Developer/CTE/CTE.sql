/* Common Table Expressions--- ( used to manipulate complex subqueries data) */

 with cte_employee as 
 ( select firstname,lastname, gender, salary
 , count(gender) over(partition by gender) as TotalGender,
 avg(salary) over (partition by gender) as AverageSalary
 from dbo.EmployeeDemographics demo join dbo.EmployeeSalary sal
 on demo.employeeid=sal.employeeid
 where salary>45000
 )
 select firstname,AverageSalary from cte_employee

--------------------- CTE Explaination--------------

/*It is an in-memory object so you have to create it along with the the query and select it for it to produce the output otherwise 
it would give error as it is not an actual object*/

