----------------- Muti-Statement Table Valued Functions ---------------------

select * from tblEmployee001

----Inline table valued function---

create function fn_ILTVF_GetEmployees()
returns table
as
return (select id,nname, cast(dateofbirth as date) as DOB from tblEmployee001)

select * from dbo.fn_ILTVF_GetEmployees()

--- Mutistatement table valued function----

create function fn_MSTVF_GetEmployees()
returns @table table(id int,name nvarchar(20), dob date)
as
begin
     insert into @table
	 select id,nname,cast(dateofbirth as date) from tblEmployee001

return
end

select * from dbo.fn_MSTVF_GetEmployees()

--- Inline table valued function works like a view----
select * from  dbo.fn_ILTVF_GetEmployees()

update dbo.fn_ILTVF_GetEmployees()
set nname='samm'
where id=1;

--- Multi statement table value function works like a stored procedure--
select * from dbo.fn_MSTVF_GetEmployees()

update dbo.fn_MSTVF_GetEmployees()
set name='samm'
where id=1;

/*
Msg 270, Level 16, State 1, Line 38
Object 'dbo.fn_MSTVF_GetEmployees' cannot be modified.*/






/* Differences

1) In an inline table valued function,the returns cannot contain the
structure of the table the function returns whereas the multi-statement
table valued function we specify the structure of the table that
gets returned

2) Inline table valued function cannot have abegin and end block 
whereas the multi-statement table valued function can have.

3) Inline table valued functions are better for performance than multi
statement table valued functions. if the given task can be achieved using an
inline table valued function always prefer to use them over multistatement
table valued function.

4) its possible to update the underlying table using an inline table valued
function, but not possible using multi statement table valued function.

Reason for improved performance of an inline table valued function:-
Internally, sql server treats an internal table valued function much like
a view whereas
it would treat a multi statement table valued function 
much like a stored procedure*/

 

