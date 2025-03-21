/* CASE Statement */

--select firstname,lastname,age,
--case
--when age=24 then 'Keyur'
--when age>30 then 'Old'
--when age between 24 and 30 then 'Young'
--when age<5 then 'baby'
--else 'no age group'
--end as "AgeClassifier"
--from dbo.EmployeeDemographics
--where age is not null
--order by age;

select firstname,lastname,jobtitle,salary,
case 
when jobtitle='Data Engineer' then salary+(salary*.10)
when jobtitle='Software Developer' then salary+(salary*.7)
when jobtitle='Banker' then salary+(salary*.5)
else salary + (salary*.4)
end as "SalaryPostRaise"
from dbo.EmployeeDemographics ed
join dbo.EmployeeSalary es
on ed.employeeid=es.employeeid







