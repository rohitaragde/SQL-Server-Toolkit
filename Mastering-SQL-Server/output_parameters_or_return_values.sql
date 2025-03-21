-------------------- Stored Procedure Output Parameters or Return Values---------

/* Whenever you execute a stored procedure it returns an integer status variable.
Usually zero indicates success and a non-zero indicates failure*/


---- Stored Procedure with Output Parameters---

select * from tblEmployee;

create procedure uspGetTotalCount1
@TotalCount int output
as
begin
select @TotalCount=count(id) from tblEmployee
end

declare @totalempcount int
exec uspGetTotalCount1 @totalempcount output
print @totalempcount

------- Stored Procedure with Return Values------------

create procedure uspGetTotalCount11
as 
begin
return(select count(id) from tblEmployee)
end

declare @totalempcount int
exec @totalempcount=uspGetTotalCount11
select @totalempcount

--------- Output Parameters VS Return values-------------------------
/* Lets look at an example where output parameters can be used while
return status variables cannot be used*/


------1 Output parameters Implementation----

create procedure uspGetNameById1
@id int,
@nname nvarchar(20) output
as
begin
	  select @nname=name from tblEmployee where id=@id
end

declare @nname nvarchar(20)
exec uspGetNameById1 1,@nname out
print 'Name= '+ @nname

---2 Return Values Implementation ----

create procedure uspGetNameById2
@id int
as
begin
	 return(select name from tblEmployee where id=@id)
end

declare @nname2 nvarchar(20)
execute @nname2=uspGetNameById2 1
print 'Name =' +@nname2

/*
Msg 245, Level 16, State 1, Procedure uspGetNameById2, Line 5 [Batch Start Line 61]
Conversion failed when converting the varchar value 'Sam' to data type int.
Completion time: 2024-08-12T19:15:51.6285076-04:00
*/

/*

Return Status Value		     Output Parameters

Only Integer Datatype	      Any Datatype
Only one value	              More than one value
Used to convey success        used to return values 
or failure	                   like name, count etc.
*/



