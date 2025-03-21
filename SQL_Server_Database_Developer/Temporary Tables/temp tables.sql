/* Temp tables
unlike CTE dont need to create as we are executing the temp tables
we can just run it and it sits there
processing speed, storage, how data is stored
it is used mostly in stored procedures where we need to create procedures and implement complex functionalities using temp tables
and we dont want to hit the production tables
temp tables are stord somewhere but occupy very less space and once the work is done we should drop them.
*/

create table #temp_employee
(employeeid int,
jobtitle varchar(100),
salary int);

select * from #temp_employee;

insert into #temp_employee values(1001,'Data Engineer',60000);
insert into #temp_employee values(1002,'Software Developer',70000);
insert into #temp_employee values(1003,'Data Designer',65000);
insert into #temp_employee values(1004,'Data Architect',69000);
insert into #temp_employee values(1001,'ML Engineer',90000);

insert into #temp_employee
select * from TUT..EmployeeSalary  /* ( TUT..EmployeeSalary ( db.. tablname dont need to mention the schems)) */

drop table if exists #temp_employee2
create table #temp_employee2
(jobtitle varchar(50),
employeesperjob int,
Avgage   int,
AvgSalary int);

insert into #temp_employee2
select jobtitle,count(jobtitle),avg(age),avg(salary)
from TUT..EmployeeDemographics emp join TUT..EmployeeSalary sal
on emp.employeeid=sal.employeeid
group by jobtitle

select * from #temp_employee2








