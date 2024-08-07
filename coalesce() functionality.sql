------------------------ Coalesce function------------------------------

/* Coalesce() function is used to return first non-null value*/

create table Emp001
(id int primary key,
FirstName varchar(10),
MiddleName varchar(10),
LastName varchar(10));

select * from Emp001;

update Emp001 set firstname='Rohit' where id=1;

select id,
coalesce(firstname,middlename,lastname) as name
from Emp001;
