/* Aliasing */

select firstname + ' ' + lastname as FullName from dbo.EmployeeDemographics;

select demo.employeeid from dbo.EmployeeDemographics as Demo


select demo.employeeid, empsal.salary from dbo.EmployeeDemographics as demo
join dbo.EmployeeSalary as empsal
on demo.employeeid=empsal.employeeid

select demo.employeeid,demo.firstname,sal.jobtitle,war.age
from dbo.EmployeeDemographics demo left join dbo.EmployeeSalary sal
on demo.employeeid=sal.employeeid
left join dbo.WarehouseEmployeeDemographics war
on demo.employeeid=war.employeeid;


