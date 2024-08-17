----------------- Functions- Important Concepts---------------------

/* Daterministic and Non-Deterministic Function

Deterministic Functions:- Always returns the same result anytime they are
                          called with a specific set of input values and
						  given the same state of the database.
examples:- Square(),Power(),Sum(),Avg() and Count()

Non Deterministic Functions:- It may return different results each time 
                             they are called with a specific set of input
							 values even if the database state that they
							 access remains the same.
examples:- getdate() and current_timestamp()

Rand() function:- It is a non-deterministic function but if you provide the
                  seed value the function becomes determinsitic as the same 
				  value gets returned for the same seed value
*/

select * from tblEmployee001

----- Deterministic----

select count(*) from tblEmployee001

select square(3)

select rand(1)  --- (with seed its deterministic)

----- Non-Deterministic-----

select getdate()

select CURRENT_TIMESTAMP

select rand() ---- (without seed its non deterministic)

--------------------------- With Encryption and SchemaBinding ------------------------------

/* Encrypting a function using with Encryption option:-

Like encrypting a stored procedure we can aslo encrypt a function
text. Once encrypted, you cannot view the text of the function,
using sp_helptext system stored procedure.

If you try to you will get a message saying 'The text or object is encrypted'.
There are ways to decrypt it.

Creating a function with SCHEMABINDING option:-

Schemabinding specifies that the function is bound to the database objects 
that it references.when SCHEMABINDING is specified the base objects cannot
be modified in any way that would affect the function definition. The function
definition must first be modified or dropped to remove dependencies 
on the object that is to be modified.
*/

alter function fn_getNameByID(@id int)
returns nvarchar(30)
with schemabinding
as
begin
    return (select nname from dbo.tblEmployee001 where id=@id)
end

drop table tblEmployee001

sp_helptext  fn_getNameByID
sp_depends fn_getNameByID

select dbo.fn_getNameByID(1)

/*
Once encrypted

sp_helptext fn_getNameByID

The text for object 'fn_getNameByID' is encrypted.

Completion time: 2024-08-16T21:42:50.2963561-04:00

*/


/*
 if you accidentally drop the table 
 associated with the function and then execute
 the function that shrows error but you dont want
 to do that and thats where Schema Bindign comes into the picture.

 When you are creating a function firstly it asks you to 
 create a two-part name for the base table otherwise it throws
 the below error:-


 Msg 4512, Level 16, State 3, Procedure fn_getNameByID, Line 6 [Batch Start Line 58]
Cannot schema bind function 'fn_getNameByID' because name 'tblEmployee001' is invalid for schema binding. Names must be in two-part format and an object cannot reference itself.

Completion time: 2024-08-16T21:48:43.1306504-04:00

And once you add the schemabinding option in the function
and then when you try to drop the associated table 
it will not allow you to drop the table and throw error:-


Msg 3729, Level 16, State 1, Line 67
Cannot DROP TABLE 'tblEmployee001' because it is being referenced by object 'fn_getNameByID'.

Completion time: 2024-08-16T21:50:01.3508478-04:00

so thats where schemabinding is very useful.

Note:- we can always check our objects dependency using:-

sp_depends system stored procedure.

*/









