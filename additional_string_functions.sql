-------------------------- String Functions---------------------------

/* We will learn about commonly used built-in string functions that
are available in SQL Server

1) ASCII(character_Expression):- Returns the ASCII code value of the given
                                 character expression.

2) CHAR ( Integer_Expression):- Converts an ASCII code to a character. The
	                            integer_expression should be between 0 and 
								255.

3) LTRIM (Character_Expression):- Removes blanks on the left handside of the given
	                              character expression.

4) RTRIM (Character_Expression):- Removes blanks on the right handside of the given
	                              character expression.

5) LOWER (Character_Expression):- Converts all the characters in the given character_
                                  expression to lowercase letters.

6) UPPER (Character_Expression):- Coverts all the characters in the given character_expression
                                  to uppercase letters.

7) REVERSE ('Any String Expression'):- Reverses all characters in the given character string.

8) len(string_expression):-  Returns the count of total characters in the given string 
                             expression excluding the blanks at the end of the
							 expression.
*/

select * from tblEmployee;

select ascii('a')

select char(97);

Declare @Start int
set @Start=97
while (@Start<=124)
Begin
     print char(@Start)
	 set @Start=@Start+1
End


select ltrim('      Hello')

select * from tblEmployee;

select ltrim(name) from tblEmployee;
select rtrim(name) from tblEmployee;

select lower(name) from tblEmployee;
select upper(name) from tblEmployee;

select reverse(name) from tblEmployee;

select len(name) from tblEmployee;

select name,len(ltrim(name)) as [Total Characters]
from tblEmployee;

------------------ Some Additional String Functions-------------------------

/*

1) LEFT(Character Expression, Integer Expression):- Returns the specified number of characters
                                                    from the left handside of the given character
													expression.



2) RIGHT (Character Expression, Integer Expression):- Returns the specified number of characters
                                                    from the right handside of the given character
													expression.


3) CHARINDEX('Expression to Find','Expression to search','start_location'):-

Returns the starting position of the specified expression in a character
string.

4) SUBSTRING ('Expression','Start','Length'):-

Returns the substring (part of the string) from the given
expression.

*/



select left('ABCDEF',4)

select right('ABCDEF',3)

select charindex('@','sara@aaa.com',1)


/* Retrieving domain from emails with hardcoded email ids and dynamic logic
using string functions*/

declare @email nvarchar(40)='ragderohit2024@gmail.com'
select substring(@email,charindex('@',@email)+1,
len(@email)-charindex('@',@email))

select substring('pam@bbb.com',charindex('@','pam@bbb.com')+1,
len('pam@bbb.com')-charindex('@','pam@bbb.com'))

/* Applying the above logic dynamicaaly on the Emp table
by takign emails from the emp table*/

select * from EmpTest;

select substring(email,charindex('@',email)+1,
len(email)-charindex('@',email)) as EmailDomain,
count(email) as Total
from Emptest
group by substring(email,charindex('@',email)+1,
len(email)-charindex('@',email)) 
















