------------------------------- Views-------------------------------------------

/* View is nothing more than a saved SQL query. A view can also be considered as a
virtual table.*/


select * from tblDept;
select * from tblEmp;

create view vWEmployeesByDepartment
as
select e.id,e.nname,e.salary,e.gender,d.deptname
from tblEmp e join tblDept d
on e.deptid=d.deptid

select * from vWEmployeesByDepartment

/* Advantages of View

1) Views can reduce the complexity of the database schema
2) Views can be used as a mechanism to implement row and column level security
3) Views can be used to present aggregated data and hide detailed data

To modify a view- Alter view statement
To drop a view-   Drop view vWName

*/

----- Row Column Security-----

create view vWITEmployees
as
select e.id,e.nname,e.salary,e.gender,d.deptname
from tblEmp e join tblDept d
on e.deptid=d.deptid
where d.deptname='IT'

select * from vWITEmployees

----- Column Level Security----

create view vWNonConfidentialData
as
select e.id,e.nname,e.gender,d.deptname
from tblEmp e join tblDept d
on e.deptid=d.deptid

select * from vWNonConfidentialData

------ Viewing Summarized Data------

create view vWSummarizedData
as
select d.deptname,count(e.id) as totalEmployees
from tblEmp e join tblDept d
on e.deptid=d.deptid
group by d.deptname

select * from vWSummarizedData


/* 
We can also achieve the above by providing access to only
the specific part of the views using grant and revoke DCL commands*/












