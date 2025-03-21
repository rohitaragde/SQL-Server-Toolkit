---------------------------- Derived Tables and CTE ----------------------------------



insert into tblEmployee0001 values(40,'Vedanti',45000,'Female',2)

select * from tblEmployee0001

select * from tblDept

---- Using Views-----

create view vWEmployeeCount
as
select deptname,departmentid, count(*) as TotalEmployees
from tblEmployee0001
join tblDept
on tblEmployee0001.departmentid=tblDept.deptid
group by deptname,departmentid

select * from vWEmployeeCount 

select deptname,TotalEmployees  from vWEmployeeCount
where TotalEmployees>=2

/* Views get saved in the database, and can be available to other queries and stored
   procedures. However, if this view is only used at this one place, it can be 
   easily eliminated using options like CTE,Derived Tables,Temp Tables, Table Variable etc
*/

---- Using Temp Tables ----

select deptname,departmentid,count(*) as TotalEmployees
into #TempEmployeeCount
from tblEmployee0001
join tblDept
on tblEmployee0001.departmentid=tblDept.deptid
group by deptname,departmentid

select deptname,TotalEmployees
from #TempEmployeeCount
where TotalEmployees>=2

drop table #TempEmployeeCount

/* Temporary Tables are stored in TempDB. Local Temporary tables are visible only in
   the current session and can be shared between nested and stored procedure calls.
   Global temporary tables are visible other sessions and destroyed when the last
   connection referencing the table is closed*/

------- Table Variable -------

Declare @tblEmployeeCount table(deptname nvarchar(20), DepartmentId int,
 TotalEmployees int)

 insert @tblEmployeeCount
 select deptname,departmentid,count(*) as TotalEmployees 
 from tblEmployee0001 join tblDept
on tblEmployee0001.departmentid=tblDept.deptid
group by deptname,departmentid

select deptname,TotalEmployees 
from @tblEmployeeCount
where TotalEmployees>=2

/* Note:- Just like TempTables, a table variable is also created in TempDB. The scope
          of a table variable is the batch, stored procedure, or statement block 
		  in which it is declared. They can be passed as parameters between
		  procedures.

Advantage of using table variable is that you dont have to drop it like
temporary table
*/

-------- Using Derived Tables ---------

select deptname, TotalEmployees 
from 
     (	
	 
		select deptname,departmentid,count(*) as TotalEmployees 
		from tblEmployee0001 join tblDept
		on tblEmployee0001.departmentid=tblDept.deptid
		group by deptname,departmentid

	)
as EmployeeCount
where TotalEmployees>=2

/* 
EmployeeCount is the derived table.
Note:- Derived tables are available only in the context of the current query
*/

------ Using CTE ---------

with EmployeeCount(deptname,departmentid,TotalEmployees)
as
(
   select deptname,departmentid,count(*) as TotalEmployees 
		from tblEmployee0001 join tblDept
		on tblEmployee0001.departmentid=tblDept.deptid
		group by deptname,departmentid

)

select deptname,TotalEmployees 
from EmployeeCount
where TotalEmployees>=2

/* Note:- A CTE can be thought of as a temporary resultset that is defined within the
          execution scope of a single SELECT,INSERT,UPDATE,DELETE, or CREATE VIEW 
		  statement. A CTE is similar to a derived table in that it is not stored 
		  as an object and lasts only for the duration of the query.

*/




