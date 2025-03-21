------------------------------- Recursive CTEs-----------------------------------------

create table EmpMgr
(employee_id int primary key,
 emp_name varchar(12),
 managerid int)

insert into EmpMgr values(1,'Tom',2)
insert into EmpMgr values(2,'Josh',NULL)
insert into EmpMgr values(3,'Mike',2)
insert into EmpMgr values(4,'John',3)
insert into EmpMgr values(5,'Pam',1)
insert into EmpMgr values(6,'Marry',3)
insert into EmpMgr values(7,'James',1)
insert into EmpMgr values(8,'Sam',5)
insert into EmpMgr values(9,'Simon',1)

select * from EmpMgr

----- A simple Self Join -----

/* Joining a table with itself is called Self Join */

select e.emp_name as employee_name,
      isnull(m.emp_name,'Super Boss') as 'Manager Name'
	  from EmpMgr e left join EmpMgr m
	  on e.managerid=m.employee_id


/*

In the above example we were able to diplay employees along with their manager names
using a simple self join but lets say along with the employee and their manager's name,
we also want to diplay their level in the organization so to achieve this we would
use a Recursive CTE

*/

/* If you want to refer a keyword as a columname wrap that in square brackets*/

select * from empmgr


with
EmployeesCTE (employee_id,emp_name,managerid,[Level])
as
(
   select employee_id,emp_name,managerid,1
    from EmpMgr
   where managerid is null

   union all

   select EmpMgr.employee_id,EmpMgr.emp_name,
          EmpMgr.managerid,EmployeesCTE.[Level]+1
   from EmpMgr join EmployeesCTE
   on EmpMgr.managerid=EmployeesCTE.employee_id
)

select EmpCte.emp_name as Employee, isnull(MgrCte.emp_name,'Super Boss') as Manager,
       EmpCte.[Level]
from EmployeesCTE EmpCte 
left join EmployeesCTE MgrCte
on EmpCte.managerid=MgrCte.employee_id



