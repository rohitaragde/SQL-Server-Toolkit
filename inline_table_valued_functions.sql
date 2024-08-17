---------------------- Inline Table Valued Functions------------------------------

/*

Scalar Function:- Returns a scalar value
Inline Table Valued Function:- Returns a table

1) We specify table as the returntype instead of scalar datatype
2) the function body is not enclosed within begin and end block
3) THe structure of the table that gets returned is determined 
by the select statement within the function.
*/

select * from tblEmployee001

----- Creating Inline Table Valued Functions-----

create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
    return (select id,dateofbirth,gender,departmentid
	        from tblEmployee001
			where gender=@Gender)

------ Invoking Inline Table Valued Functions------

select * from fn_EmployeesByGender('Male')

select * from tblDepartment

select e.id,e.gender,d.departmentname
from fn_EmployeesByGender('Male') E
join tblDepartment d on d.id=e.id;

/*

1) Inline Table valued functions can be used to achieve the functionality
   of parameterized views.

2) The table returned by the table valued function can also be used to
   join with other tables

*/















