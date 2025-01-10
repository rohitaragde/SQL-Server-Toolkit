------------------- Alter database table columns without dropping table -------------------

use [mastering_sql_server]
select * from tblEmployee 

select gender, sum(salary) as Total
from tblEmployee 
group by gender 

/*  8117, Level 16, State 1, Line 6
Operand data type nvarchar is invalid for sum operator.

Completion time: 2024-11-06T19:24:55.4430051-05:00
*/

/* we cannot use the salary column with the sum aggregate function
because its datatype is nvarchar and hence we need to change
the datatype to int

When tried to do with the design GUI it says we have to drop and re-create
the table changing is not permitted

*/

------------ Without the need to drop, re-create and again populate the table with data -------------

----------- Option 01: Use a SQL Query to alter the column as shown below -------------

alter table tblEmployee 
alter column salary int 

------------ Option 02: Disable "Prevent Saving changes that require table re-creation option "----------

------------ Now lets try to execute the query -------------

select gender, sum(salary) as Total
from tblEmployee 
group by gender 

/*

now, its working as expected.

gender	Total
Female	10700
Male	15000

*/









