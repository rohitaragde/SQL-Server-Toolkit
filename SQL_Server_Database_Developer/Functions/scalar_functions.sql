--------------------------------------- User Defined Functions-------------------------------------------
---- There are several types of user defined functions:-
---1) Scalar Functions
---2) Inline table-valued functions
---3) Multi-statement table-valued functions

---- In this session we are going to cover scalar udfs

--- Scalar functions may or may not have parameters but they always return a single(scalar) value. The
--returned value can be of any datatype except text, ntext,image, cursor and timestamp


--- Syntax to create a Scalar Function-----------

/*create function function_name(@parameter1 datatype, @parameter2 datatype,..@parametern datatype)
returns return_datatype
as
begin
	  ---Function Body
	  return return_datatype
end
*/


-------------------------------------Creating First Function-----------------------------------------------
CREATE FUNCTION CalculateAge(@dob DATE)
RETURNS INT
AS 
BEGIN
    DECLARE @age INT

    SET @age = DATEDIFF(YEAR, @dob, GETDATE())
    IF (MONTH(@dob) > MONTH(GETDATE())) OR 
       (MONTH(@dob) = MONTH(GETDATE()) AND DAY(@dob) > DAY(GETDATE()))
    BEGIN
        SET @age = @age - 1
    END

    RETURN @age
END
end


select CalculateAge('08/12/1997')---- ( it considers it as system function)
select dbo.CalculateAge('08/12/1997') as Age ----- ( for scalar function use dbo(database owner)(two part name)
select tempDb.dbo.CalculateAge('08/12/1997') as Age---(three part name)



select * from tblEmployee111

select name,dateofBirth,dbo.CalculateAge(dateofBirth) as Age
from tblEmployee111 where dbo.CalculateAge(dateofBirth)>40

sp_helptext CalculateAge

select id,name,dbo.CalculateAge(dateofBirth) as Age
from tblEmployee111


---- You can use functions in select an dwhere clauses but cannot be used in stored procedures
