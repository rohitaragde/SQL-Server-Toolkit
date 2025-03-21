------------------------ Retrieving Identity Columns---------------------------

/* we know that the identity columns are auto generated, there are several
ways in sql server, to retrieve the last identity value that is generated.
the most common way is to use SCOPE_IDENTITY() built in function.

You can also use @@IDENTITY and IDENT_CURRENT('TableName')

SCOPE_IDENTITY()- Same session and the same scope
@@IDENTITY- Same session and across any scope
IDENT_CURRENT('TableName')- Specific table across any session and scope.

*/

create table Test01
(id int identity(1,1),
value nvarchar(20));

create table Test02
(id int identity(1,1),
value nvarchar(20));

insert into Test01 values('X');

select * from Test01;
select * from Test02;

create trigger trForInsert on Test01 for Insert
as
Begin
	insert into Test02 values('YYYY')
End

---- Utilize two sql server windows to perform the following-----------

------- User1 ----------

insert into Test02 values('zzz');

select SCOPE_IDENTITY()
select @@IDENTITY
select IDENT_CURRENT('Test02');


---------- User 2 ------------

insert into Test02 values('zzz');

select IDENT_CURRENT('Test02');


















