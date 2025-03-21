-----------------Advantages of Stored Procedures--------------

--1) Execution Plan Retention and Reusability
--2) Reduces network traffic
--3) Code reusability and better maintainability
--4) Avoids SQL Injection Attack

select * from tblEmployee

create procedure spGetNameById
@Id int
as
Begin
	  select Name from tblEmployee where Id=@Id 
End

exec spGetNameById 1
exec spGetNameById 2


----In case of stored procedure the same
--execution plan is used even if you change
-- the parameters and hence the execution plan retention--


select Name from tblEmployee where Id=1
select Name from tblEmployee where Id=2

-- For Adhoc SQL Queries:-
--- The query engine will use the same query plan if 
-- the parameter is same and just the value is changing 
-- but if you change the parameter a new execution plan is generated--
