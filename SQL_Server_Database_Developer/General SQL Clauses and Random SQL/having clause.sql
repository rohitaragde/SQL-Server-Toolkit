/* Having Clause */

select jobtitle, count(jobtitle) from dbo.EmployeeDemographics ed
join dbo.EmployeeSalary es
on ed.employeeid=es.employeeid
where age>25
group by jobtitle
having count(jobtitle)>1;

select jobtitle, avg(salary) from dbo.EmployeeDemographics ed
join dbo.EmployeeSalary es
on ed.employeeid=es.employeeid
where age>25
group by jobtitle
having avg(salary)>45000
order by avg(salary)  







select * from dbo.EmployeeDemographics

select * from dbo.EmployeeSalary

