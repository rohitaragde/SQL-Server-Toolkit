----------------- ------ Common Table Expressions (CTE)---------------------------

/*

Common Table Expressions(CTE) is a temporary resultset that can be referenced within a
Select,Insert,Update or Delete statement that immediately follows the CTE.\

Syntax:-

with cte_name(column1,column2,.... column n)
as
(CTE_Query)

*/

select * from tblEmployee0001
select * from tblDept

with EmployeeCount(DepartmentId,TotalEmployees,XYZ)
as
(
	 select departmentid, count(*) as TotalEmployees
	 from tblEmployee0001
	 group by departmentid
)

select deptname, TotalEmployees 
from tblDept
join EmployeeCount
on tblDept.deptid=EmployeeCount.departmentid
order by TotalEmployees

/* 

1) even if we dont specify the columnames in the signature of the CTE creation
   we will still end up getting the same result
   
2) If you do specify the columns there must be mapping in the signature and the
   actual select statement within the CTEotherwise it will throw error
   
Msg 8159, Level 16, State 1, Line 19
'EmployeeCount' has fewer columns than were specified in the column list.

Completion time: 2024-08-30T18:54:26.4356807-04:00


*/

with EmployeeCount(DepartmentId,TotalEmployees,XYZ)
as
(
	 select departmentid, count(*) as TotalEmployees
	 from tblEmployee0001
	 group by departmentid
)
select 'Hello'

select deptname, TotalEmployees 
from tblDept
join EmployeeCount
on tblDept.deptid=EmployeeCount.departmentid
order by TotalEmployees

/* 

		A CTE can only be referenced by SELECT,INSERT,UPDATE or DELETE statement
		that immediately follows the CTE

		The select query referencing the CTE must follow the CTE definition
		and nothing else must be placed in between and if places it
		throws error:-

		Msg 422, Level 16, State 4, Line 58
		Common table expression defined but not used.

		Completion time: 2024-08-30T18:56:09.9494119-04:00


*/

---- Creating multiple CTE's using a single WITH Clause -----

with EmployeesCountBy_Payroll_IT_Dept(departmentname,total)
as
   (
      select deptname,count(id) as TotalEmployees
	  from tblEmployee0001
	  join tblDept
	  on tblEmployee0001.departmentid=tblDept.deptid
	  where deptname in('Payroll','IT')
	  group by deptname 
	),

EmployeesCountBy_HR_Admin_Dept(departmentname,total)
as
   (
      select deptname, count(id) as TotalEmployees 
	  from tblEmployee0001
	  join tblDept
	  on tblEmployee0001.departmentid=tblDept.deptid
	  where deptname in('HR','Admin')
	  group by deptname
	)

select * from EmployeesCountBy_Payroll_IT_Dept
union
select * from EmployeesCountBy_HR_Admin_Dept





