------------------------------- Updateable Views-------------------------------------

/* An updatable view means that when you update delete or insert a view
 the changes are reflected in the base table as well on top of which 
 the view has been created!

 For instance we have an Employee table and we want to hide the salary column
 so we create a view without the salary column for the user so we can grant
 access as needed but in this case e just created a view without the salary 
 column.

 Now, we can perform insert, update and delete operations on the view
 and the same will be reflected in the base table as well and hence
 updateable views
 */

select * from tblEmp09

---Creating View without the salary column and retrieving data -----

create view vWEmployeesDataExceptSalary
as
select id,nname,gender,departmentid
from tblEmp09

select * from vWEmployeesDataExceptSalary

/*
Is it possible to insert,update and delete from the base table tblEmp09
through the view?*/


select * from vWEmployeesDataExceptSalary

/*
update vWEmployeesDataExceptSalary ?
insert into vWEmployeesDataExceptSalary ?
delete from vWEmployeesDataExceptSalary ?
*/

--- Updating the View ----

update vWEmployeesDataExceptSalary
set nname='Mickey' where id=2;

--- Deleting the View ---
delete from vWEmployeesDataExceptSalary
where id=2

--- Inserting data into the View ---
insert into vWEmployeesDataExceptSalary values(2,'Mickey','Male',2)

--- Selecting Data from the updateable View --

select * from vWEmployeesDataExceptSalary


select * from tblemp09;

select * from tblDepartment09

---- Creating updateable views with multiple tables-----

create view vwEmployeeDetailsByDepartment
as
select id,nname,salary,gender,deptname
from tblemp09 t join tblDepartment09 d
on t.departmentid=d.departmentid

select * from vwEmployeeDetailsByDepartment

--- Updating updateable views having multiple base tables----

update vwEmployeeDetailsByDepartment
set deptname='IT' where nname='John'

/* In the above query ideally John's department which was only that record
  must be changes to IT but when we check the output all toher employees
  with departmentname as HR are also changed to IT simply because view
  does not have any storage of itself to store the view so each time

  [ Materialized views store view objects that we willl look later on]

  its created it queries the base table and hence when we ran the update
  we had employee and dept tables and instead of changing the deptid to 1
  it updated the deptname to IT and hence when we select both the employees
  had their department as IT thats what is the issue with updateable views*/


  /*
  If a view is based on multiple tables and if you update the view it may not
  update the underlying base tables correctly. To correctly update a view,
  that is based on multiple tables, INSTEAD OF triggers are used*/



