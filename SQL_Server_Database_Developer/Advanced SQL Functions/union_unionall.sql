/* Union, Union All */

--- similar datatypes, no of columns same for union and union all to work----------

select * from dbo.EmployeeDemographics

select * from dbo.EmployeeSalary

select employeeid, firstname, age from dbo.EmployeeDemographics
union
select employeeid,jobtitle,salary from dbo.EmployeeSalary;



select *from dbo.EmployeeDemographics
union all
select * from [TUT].[dbo].[WarehouseEmployeeDemographics]
order by employeeid


SELECT * INTO dbo.WarehouseEmployeeDemographics FROM dbo.EmployeeDemographics;





