USE [TUT]
GO
/****** Object:  StoredProcedure [dbo].[temp_employee]    Script Date: 02/03/2024 14:43:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[temp_employee]
@jobtitle nvarchar(100)
as
create table #temp_employee(
jobtitle varchar(100),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)


insert into #temp_employee
select jobtitle,count(jobtitle),avg(age),avg(salary)
from TUT..EmployeeDemographics emp join TUT..EmployeeSalary sal
on emp.employeeid=sal.employeeid
where jobtitle=@jobtitle
group by jobtitle


select * from #temp_employee 
