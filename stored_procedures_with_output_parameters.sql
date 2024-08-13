
------------------------ Stored procedures with Output parameters ----------------

/* to create a stored procedure with output parameters we use the keywords OUT
or output*/

create procedure uspGetEmployeeCountByGender
@gender nvarchar(20),
@employeecount int out
as
begin
select @employeecount=count(id) from tblEmployee where gender=@gender 
end

/* the datatype of the variable that receives the output
should match with the datatype of the output variable
if you do not pass the out keyword along with the variable
it does not recieve a value and its by default NULL so it
wont return any value*/


declare @EmployeeCount int
exec uspGetEmployeeCountByGender 'Male',@EmployeeCount output  
if(@EmployeeCount is null)
   print '@EmployeeCount is null'
else
   print '@EmployeeCount is not null'
print @EmployeeCount

/* Just printing the output parameter value without the checking*/

declare @EmployeeCount int
exec uspGetEmployeeCountByGender 'Male',@EmployeeCount output  
print @EmployeeCount

/* If you pass the names of the parameters then the 
sequence does not matter*/

declare @TotalCount int
exec uspGetEmployeeCountByGender @EmployeeCount= @TotalCount output,@gender='Male' 
print @TotalCount

/* Some useful system stored procedures which can be used for a
varierty of purposes

a) sp_help procedure_name:- View the information about the stored procedure like
				           parameter names, datatypes etc, sp_help can be used
						   with any database object like tables,views,sps,triggers etc.



b) sp_helptext procedure_name:- View the text of the stored procedure.

c) sp_depends procedure_name:- View the dependencies of the stored procedure.
							   This system SP is very useful especially if you
							   want to check if there are any stored procedures
							   that are referencing a table that you are about to
							   drop.sp_depends can also be used with other database
							   objects like tables etc.
*/


sp_help uspGetEmployeeCountByGender
sp_helptext uspGetEmployeeCountByGender
sp_help tblEmployee
sp_depends uspGetEmployeeCountByGender
sp_depends uspGetEmployees
sp_depends tblEmployee







