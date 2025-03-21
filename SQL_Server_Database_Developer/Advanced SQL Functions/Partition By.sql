/* Partition By */

select * from dbo.EmployeeDemographics;

select * from dbo.EmployeeSalary;


------------- Partiion By ( Partitions on that column so we can partition and get the other columns as well)-----------

select firstname, lastname,gender,salary, 
count(gender) over (partition by gender ) as TotalGender
from dbo.EmployeeDemographics demo join dbo.EmployeeSalary sal
on demo.employeeid=sal.employeeid

--- Group By----  ( rolls up for that particular column so we cant have other columns)
select gender,count(gender)
from dbo.EmployeeDemographics demo join dbo.EmployeeSalary sal
on demo.employeeid=sal.employeeid
group by gender






