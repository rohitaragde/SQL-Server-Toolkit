------------------- Different ways to replace NULL values ----------------------

select * from tblEmployee0001

/* is null function checks for null values
the first parameter is the expression that checks for null
and the second parameter is the replacement value that
you want to replace the Null with*/

select e.empname as employee,
isnull(m.empname,'No Manager') as Manager
from tblEmployee0001 e left join  tblEmployee0001 m
on e.managerid=m.employeeid;

/* Coalesce function is similar to isnull() function
but it has more functionality as in it can have multiple expressions.

Coalesce is basically used to return the first non null value*/

select e.empname as employee,
coalesce(m.empname,'No Manager') as Manager
from tblEmployee0001 e left join  tblEmployee0001 m
on e.managerid=m.employeeid;

/* Case statement is used to wrap consitions in case statements
to return specific outputs and replace null values and several other use cases*/

select e.empname as employee,
case when m.empname is null then 'No Manager' else m.empname end as Manager
from tblEmployee0001 e left join  tblEmployee0001 m
on e.managerid=m.employeeid;

