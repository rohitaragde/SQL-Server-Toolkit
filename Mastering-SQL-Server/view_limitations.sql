--------------------------------- View Limitations------------------------------------
/*

1) You cannot pass parameters to a view. Table Valued functions are an excellent
   replacement for parameterized views.

2) Rules and Defaults cannot be associated with views.

3) The ORDER BY clause is invalid in views unless TOP or FOR XML is also specified.

4) Views cannot be based on temporary tables

*/



select * from  tblEmployee004

create view vWEmployeeDetails
as
select id,nname,gender,departmentid
from tblEmployee004

select * from vWEmployeeDetails

-- View with parameters----
--- Error: Cannot pass parameters to Views ---
create view vWEmployeeDetails
@Gender varchar(10)
as
select id,nname,gender,departmentid
from tblEmployee004
where gender=@Gender


--- You can filter Gender in the Where clause ----

select * from vWEmployeeDetails where Gender='Male'

---- Inline Table Valued Functions as a replacement for Parameterized Views ---

create function fnEmployeeDetails(@Gender nvarchar(20))
returns table
as
return
(select id,nname,gender,departmentid
from tblEmployee004
where gender=@Gender)

/* 
To invoke the function use the two-part-name*/

select * from dbo.fnEmployeeDetails('Female')

---- cannot use order by in views

alter view vWEmployeeDetails
as
select id,nname,gender,departmentid
from tblEmployee004
order by id 

/*
Msg 1033, Level 15, State 1, Procedure vWEmployeeDetails, Line 6 [Batch Start Line 53]
The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and common table expressions, unless TOP, OFFSET or FOR XML is also specified.

Completion time: 2024-08-21T21:52:39.6773096-04:00
*/


---Usage of Views in temporary tables----


create table ##TestTempTable 
(id int, nname nvarchar(20), gender nvarchar(10))

/*
## means Global Temp Table and hence can be accessed from any session*/ 

insert into ##TestTempTable values(101,'Martin','Male')
insert into ##TestTempTable values(102,'Joe','Female')
insert into ##TestTempTable values(103,'Pam','Female')
insert into ##TestTempTable values(104,'James','Male')

select * from ##TestTempTable

---- Error:Views are not allowed on Temporary tables ---

create view vwOnTempTable
as
select id,nname,gender
from ##TestTempTable


/*
Msg 4508, Level 16, State 1, Procedure vwOnTempTable, Line 4 [Batch Start Line 86]
Views or functions are not allowed on temporary tables. Table names that begin with '#' denote temporary tables.

Completion time: 2024-08-21T22:04:33.4698696-04:00
*/











