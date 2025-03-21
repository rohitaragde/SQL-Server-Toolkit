------------------------ Advantages of Stored procedures----------------------

/* Advantages of using stored procedures is that:-
1) Execution plan retention and reusability
2) Reduces network traffic
3) Code reusability and better maintainability
4) Better Security
5) Avoids SQL Injection Attack
*/

alter procedure uspGetNameById1  
@id int
as  
begin  
   select name from tblEmployee where id=@id  
end  

/*
When executing the select query multiple time for each execution
a new execution plan is generated whereas in case of stored
procedure for each new execution the same query execution plan
is utilized.

But a simple space or even the smallest change in the query
will generate a new query exectuion plan but thats not the
case with stored procedure they will reuse the execution plan.

select name from tblEmployee where id=1
select name from tblEmployee where id=2

exec uspGetNameById1 1
exec uspGetNameById1 2

Stored procedures reduce network traffic as they reside inside
the sql server you just have to mention the name of the stored
procedure along with the parameters while in other objects or
queries you will have to pass all the adhoc sql statements from client tool
to the sql server which will increase the network traffic.


In case of bus or logic change,we need to change at only one place
which is being used by multiple applications and
hence maintainability of stored procedures is also better

Better security by granting access to only the stored procedures
and not the underlying tables.

They can avoid SQL Injection Attack!


*/





