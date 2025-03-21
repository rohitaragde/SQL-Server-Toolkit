select * from TUT..EmployeeDemographics

create table dbo.ProjectDetails
(ProjectID int primary key,
 employeedetailid int,
 projectname varchar(20));

 insert into dbo.ProjectDetails values(1,1,'Task Track');
 insert into dbo.ProjectDetails values(9,6,'GL Management');

 select * from dbo.ProjectDetails


 select department,sum(salary) as "empsal"
 from dbo.EmployeeDemographics
 group by department
 order by empsal desc

 
 select department,count(*) as dept_count,
 sum(salary) as "empsal"
 from dbo.EmployeeDemographics
 group by department

  select department, min(salary) as "minempsal"
 from dbo.EmployeeDemographics
 group by department
 order by minempsal asc


 select projectname,count(*) as "NoOfEmp" from dbo.ProjectDetails
 group by projectname
 having count(*)>1

 
 select * from dbo.ProjectDetails

 
 select * from dbo.EmployeeDemographics

 select concat(firstname, ' ', lastname) as employee_name,
 projectname,

 Get employee name, project name order by firstname from "EmployeeDetail" and 
"ProjectDetail" for those employee which have assigned project already

select ed.firstname,pd.projectname
from dbo.EmployeeDemographics ed left join dbo.ProjectDetails pd
on ed.employeeid=pd.employeedetailid
order by ed.firstname

select ed.firstname,isnull(pd.projectname,'No Project Assigned') as project_name
from dbo.EmployeeDemographics ed left outer  join dbo.ProjectDetails pd
on ed.employeeid=pd.employeedetailid
where pd.projectname is null

select pd.projectname from dbo.EmployeeDemographics ed right outer  join dbo.ProjectDetails pd
on ed.employeeid=pd.employeedetailid
where firstname is null

select ed.employeeid,ed.firstname,pd.projectname as project_name
from dbo.EmployeeDemographics ed join dbo.ProjectDetails pd
on ed.employeeid=pd.employeedetailid
where employeeid in(select employeedetailid from ProjectDetails group by employeedetailid having count(*)>1);



select pd.projectname,ed.firstname from dbo.ProjectDetails pd
inner join dbo.EmployeeDemographics ed
on pd.employeedetailid=ed.employeeid
where pd.projectname in(select projectname from ProjectDetails group by projectname having count(1)>1);











select ed.firstname,pd.projectname
from dbo.EmployeeDemographics ed full outer join dbo.ProjectDetails pd
on ed.employeeid=pd.employeedetailid
order by ed.firstname

 

 
 
 
 select * from dbo.EmployeeDemographics
















 
