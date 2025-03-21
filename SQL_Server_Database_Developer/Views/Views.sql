--------------------------------------Views-----------------------------------------------

-- A view is nothing more than a saved SQL Query
-- A view can also be considered as a virtual table

create table EmpT
(id int primary key,
name varchar(10),
salary int,
gender varchar(5),
departmentid int foreign key references DeptT(deptid) )


sp_helptext vWEmployeesByDepartment

create table DeptT
(deptid int primary key,
 deptname varchar(10))

select * from DeptT 

select * from EmpT 


create View vWEmployeesByDepartment11
as
select id,name,gender,salary,deptname
from EmpT e join DeptT d
on e.departmentid=d.deptid
where d.deptname='IT'----(row level security)

create View vWEmployeesNonCOnfidentialData
as
select id,name,gender,deptname
from EmpT e join DeptT d
on e.departmentid=d.deptid

select * from vWEmployeesNonCOnfidentialData

select * from EmpT


create view VWSummarizedData
as
select deptname,count(id) as "TotalEmployees"
from EmpT e join DeptT d
on e.departmentid=d.deptid
group by d.deptname

select * from VWSummarizedData


select * from vWEmployeesByDepartment11 