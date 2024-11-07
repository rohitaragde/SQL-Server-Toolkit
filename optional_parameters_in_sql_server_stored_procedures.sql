------------------------ Optional Parameters in SQL Server Stored Procedures -------------------

use [mastering_sql_server]

select * from tblEmployee

alter procedure spSearchEmployees
@name nvarchar(50)=NULL,
@email nvarchar(50)=NULL,
@gender nvarchar(10)=NULL,
@age int=NULL
as
Begin
      select * from tblEmployee 
	  where (name=@name or @name is null) and 
	        (gender=@gender or @gender is null) and
			(email=@email or @email is null) and
			(age=@age or @age is null)
End

exec spSearchEmployees 'Sara Nan','Sara.Nan@test.com','Female',35 

/*
  order of variables defined in the stored procedure matters a lot!
  currently, it requires all the variables to be defined and to make it optional
  we just have to define default values for the variables
*/

exec spSearchEmployees 
/* specied default values and hence it works without specifying values*/

/* so above we made the stored procedure parameters optional
by specifying default values*/

---------------- Testing the stored procedure --------------------

---------- Get all the employees -------------
exec spSearchEmployees

-------- Get only Male Employees ------------
exec spSearchEmployees @gender='male'

-------- Get only Female Employees -----------
exec spSearchEmployees @gender='Female'

----- Get Male employees with age 29 --------
exec spSearchEmployees @gender='male', @age=29






