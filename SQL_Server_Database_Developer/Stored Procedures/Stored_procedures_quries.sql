/* Stored Procedure

*/

create procedure temp_employee as
create table #temp_employee(
jobtitle varchar(100),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)


insert into #temp_employee
select jobtitle,count(jobtitle),avg(age),avg(salary)
from TUT..EmployeeDemographics emp join TUT..EmployeeSalary sal
on emp.employeeid=sal.employeeid
group by jobtitle


select * from EmployeeDemographics





exec temp_employee 'Data Engineer'


select * from #temp_employee2



