-------------------------- All about Basic Joins -------------------------------

/* Joins are used to retrieve data from 2 or more related tables. In general,
tables are related to each other using foreign key constraints.*/

/* Inner join returns only the matching rows between both the tables.
Non matching rows are eliminated

Generic Join Syntax:-

select columnslist
from   Lefttable
jointype Rightable
ON		JoinCondition
*/

select * from tblEmployee;
select * from tblDepartment 

select empname,gender,salary,departmentname
from tblEmployee t inner join tblDepartment d
on t.departmentid=d.deptid

/* left Join  returns all the matching rows as well as non matching rows
from the left table*/


select * from tblEmployee;
select * from tblDepartment 

select empname,gender,salary,departmentname
from tblEmployee t left outer join tblDepartment d
on t.departmentid=d.deptid

select empname,gender,salary,departmentname
from tblEmployee t left join tblDepartment d
on t.departmentid=d.deptid

/* Right Join returns all the matching rows + non matching rows from the
right table*/

select * from tblEmployee;
select * from tblDepartment 

select empname,gender,salary,departmentname
from tblEmployee t right outer join tblDepartment d
on t.departmentid=d.deptid

/*  Full outer join returns all rows both left and the right tables 
including the non matching rows*/

select * from tblEmployee;
select * from tblDepartment 

select empname,gender,salary,departmentname
from tblEmployee t full outer join tblDepartment d
on t.departmentid=d.deptid

/* Cross Join produces the cartesian product of the 2 tables involved in the 
join. for example, in the Employees table we have 10 rows and in the Departments
table we have 4 rows. So a cross join between these 2 tables produces 40 rows.

Note:- Cross join shouldnt have the ON clause

So In this scenario we have 4 departments and 10 employees so a cross join 
would do a cartesian product and relate each department with all the 10 employees
and it will do the same for all the 4 departments and hence 40 rows.
*/

select * from tblEmployee;
select * from tblDepartment 

select empname,gender,salary,departmentname
from tblEmployee cross join tblDepartment 












