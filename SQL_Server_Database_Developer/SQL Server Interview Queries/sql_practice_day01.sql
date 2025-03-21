SELECT min(salary) as "Highest Salary" from TUT..EmployeeSalary


#Date Query
select * from TUT..EmployeeDemographics

SELECT FORMAT (DOJ, 'hh:mm:ss') as date from TUT..EmployeeDemographics;

select format(DOJ,'yyyy') as date from TUT..EmployeeDemographics;

select datepart(day,DOJ) as date from TUT..EmployeeDemographics;

SELECT FORMAT (getdate(), 'dddd, MMMM, yyyy','es-es') as date--- spanish

SELECT FORMAT (getdate(), 'dddd dd, MMMM, yyyy','ja-jp') as date --Japanese

select getdate() as "System Date"---- System Date

select getutcdate() as "UTC Date" --- UTC Date

select firstname,getdate() as "System Date",DOJ,DATEDIFF(MM,DOJ,GETDATE()) as total_months
from TUT..EmployeeDemographics

select firstname,getdate() as "System Date",DOJ,DATEDIFF(DD,DOJ,GETDATE()) as total_days
from TUT..EmployeeDemographics

select * from TUT..EmployeeDemographics
where DOJ between '2024-04-06' and '2024-04-08'

select count(*) from TUT..EmployeeDemographics
















