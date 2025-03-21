-------------------------------------- Stored Procedures ---------------------------------------------------------

select * from tblEmployee;

create procedure updateEmp
as
Begin

update tblEmployee set deptid=10 where gender='Female'
update tblEmployee set deptid=20 where gender='Male'

End





alter Procedure spGetEmployeesByGenderDept
@Gender nvarchar(10),
@Deptid int
with encryption
as
Begin
	select * from tblEmployee where gender=@Gender and deptid=@Deptid
End

exec sp_helptext spGetEmployeesByGenderDept

exec spGetEmployeesByGenderDept 'male',20

alter Procedure spInsertEmployees01
@name varchar(10),
@gender varchar(10),
@salary int
as 
Begin
	   insert into tblEmployee values(@name,@gender,@salary)
	   select * from tblEmployee
End

exec spInsertEmployees01 'Vasant','Male',60000

sp_helptext spGetEmployeesByGenderDept