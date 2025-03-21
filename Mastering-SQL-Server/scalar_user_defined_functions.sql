------------------------- User Defined Functions------------------------------

/*
In SQL Server, there are 3 types of User Defined Functions:-
1) Scalar Functions
2) Inline table-valued functions
3) Multi-statement table-valued functions

Scalare functions may or may not have parameters but always return a single(scalar)
value. The returned value can be of any datatype except text,ntext,image,
cursor and timestamp

--- To create a function we use the following syntax--

create function function_name( @Parameter1 datatype, @Parameter2 datatype,..@parameterN datatype)
returns return_datatype
as
begin
     --- Function Body
	 return return_datatype
end

*/


create function CalculateAge(@DOB date)
returns int
as
begin
declare @age int

set @age=datediff(year,@dob,getdate())-
         case when month(@dob)>month(getdate()) OR
		           month(@DOB)=month(getdate()) and day(@dob)>day(getdate())
		 then 1
		 else 0
		 end
RETURN @age
end

/*
To invoke a scalar user defined function you must
supply a two-part name, ownername.functionname where
dbo stands for database owner.

select dbo.CalculateAge('08/12/1997')

You can also invoke it using a 3 part name,
databasename.ownername.functionname

select AdventureWorksDW2019.dbo.calculateAge('08/12/1994')

*/

select dbo.CalculateAge('08/12/1997')

select AdventureWorksDW2019.dbo.calculateAge('08/12/1994');


select * from tblEmployee001




select nname,dateofbirth,
dbo.calculateAge(dateofbirth) as age
from tblEmployee001

select nname,dateofbirth,
dbo.calculateAge(dateofbirth) as age
from tblEmployee001
where dbo.calculateAge(dateofbirth)>30



/* A stored procedure also can accept DateofBirth and return age, but you
cannot use stored procedures in a select or where clause. This is just one
difference between a function and a stored procedure.

To alter a function we can use:-

Alter function functionname

and to delete it we use:-

drop function functionname

*/








