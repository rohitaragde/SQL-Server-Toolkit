-------------------------- Updatable CTEs-------------------------------------

/*
 Is it possible to update a CTE:- Yes and No
*/


----------------------- CTE on one base table --------------------------------

select * from tblEmployee0001

select * from tblDept


----- Basic selection on CTE-----

with Employees_Name_Gender
as
   (  
      select id,name,gender
	  from tblEmployee0001
	)

select * from Employees_Name_Gender


---- Updating a CTE ----

with Employees_Name_Gender
as
   (  
      select id,name,gender
	  from tblEmployee0001
	)

update Employees_Name_Gender
set gender='male' where id=20

/*

So if a CTE is created on one base table then it is possible to update the CTE,
which in turn will update the underlying base table.

In this case, Updating Employees_Name_Gender CTE, updates the tblEmployee0001 
table

*/

-----------  CTE on  2 base tables ----------------------
------ Update affecting only one base table--------------------

with EmployeesByDepartment
as
   (
      select id,name,gender, deptname
	  from tblEmployee0001
	  join tblDept
	  on tblEmployee0001.departmentid=tblDept.deptid
    )

update EmployeesByDepartment set gender='Male' where id=8


select * from tblEmployee0001

/*

If the CTE is based on more than one table and if the update statement
affects only one base table then the update is allowed

*/


------ CTE on 2 base tables -------
----- Update affecting more than one base table -------

with EmployeesByDepartment
as
   (
       select id,name,gender,deptname
	   from tblEmployee0001
	   join tblDept
	   on tblDept.deptid= tblEmployee0001.departmentid
	)

update EmployeesByDepartment set gender='Female', deptname='IT'
where id=20

/*
Msg 4405, Level 16, State 1, Line 77
View or function 'EmployeesByDepartment' is not updatable because the modification affects multiple base tables.

Completion time: 2024-08-30T20:03:53.6995835-04:00


Note:- if a CTE is based on multiple tables, and if the update statement
       affects more than one base table, then the update is not allowed
*/

with EmployeesByDepartment
as 
(
   select id,name,gender,deptname
   from tblEmployee0001
   join tblDept
   on tblEmployee0001.departmentid=tblDept.deptid
 )

 update EmployeesByDepartment set deptname='IT' where id=8

 select * from tblEmployee0001

 select * from tblDept

 /*

 Note:- A CTE is based on more than one base table and if
        the update affects only one base table, the update
		succeeds ( but not as expected always)

In the above example,

 update EmployeesByDepartment set deptname='IT' where id=8

 We are trying to chnage the department of employeeid 08 which 
 is keyur to IT but what SQL server does is it first
 checks the current department of keyur which is admin which
 belongs to departmentid 4 and it updates 4 to IT and 
 then all other people belonging to 4 changed to IT
 so basically we have 2 IT departments dept id 1 and 4
 which is incorrect and thats why CTE with more than one base table
 and the update affecting only ne base table will not always
 work as expected
 */

 /*

 Updatable CTE

1) If a CTE is based on a single base table,then the update succeeds and 
   and works as expected.

2) If a CTE is based on more than one base table, and if the UPDATE affects
   multiple base tables, the update is not allowed and the statement terminates
   with an error.

3) If a CTE is based on more than one base table, and if the UPDATE affects
   only one base table, the UPDATE succeeds ( but not as expected always)

*/














