---------------------------- Stored Procedures ----------------------------------

/* A stored procedure is a group of T-SQL ( transact SQL) statements. If you have a
situation where you write the same query over and over again you can save that
specific query as a stored procedure and call it just be its name*/

create table tblEmployee
(name varchar(10),
 gender varchar(10));

 insert into tblEmployee values('Sam','Male');
 insert into tblEmployee values('Ram','Male');
 insert into tblEmployee values('Sara','Female');
 insert into tblEmployee values('Todd','Male'); 
 insert into tblEmployee values('John','Male');
 insert into tblEmployee values('Sara','Female');
 insert into tblEmployee values('James','Male');
 insert into tblEmployee values('Rob','Male');
 insert into tblEmployee values('Steve','Male');
 insert into tblEmployee values('Pam','Female');

 select * from tblEmployee;

create procedure uspGetEmployees
as
begin
	select name,gender from tblEmployee
end

exec uspGetEmployees


------------------ Stored procedure with parameters -------------------------

select * from tblEmployee;

create procedure uspGetEmployeesByGenderAndDept
@gender nvarchar(20),
@deptid int
as
begin
      select name,gender,deptid from tblEmployee
	  where gender=@gender and deptid=@deptid
end

exec uspGetEmployeesByGenderAndDept 'Female', 2

/* When you have multiple parameters in a stored procedure
the order in which you pass the values is really important
because sql server implicitly performs conversion

so if 2 is passed where a char is expected it will convert it to char
but if a char is passed where int is expected it fails and hence
the order is very important*/

/* To view the definition of the stored procedure*/

sp_helptext uspGetEmployees

/* to chnage the definition of the stored procedure use alter statement*/

alter procedure uspGetEmployeesByGenderAndDept
@gender nvarchar(20),
@deptid int
as
begin
      select name,gender,deptid from tblEmployee
	  where gender=@gender and deptid=@deptid
end


/* to drop the procedure*/

drop procedure uspGetEmployeesByGenderAndDept

/* to encrypt the text of the stored procedure*/

alter procedure uspGetEmployeesByGenderAndDept
@gender nvarchar(20),
@deptid int
with encryption
as
begin
      select name,gender,deptid from tblEmployee
	  where gender=@gender and deptid=@deptid
end


/*if somevody tries to get the text of the stored procedure
we get error message saying
The text for object 'uspGetEmployeesByGenderAndDept' is encrypted.

Completion time: 2024-08-12T17:43:22.5728070-04:00

*/

sp_helptext uspGetEmployeesByGenderAndDept









