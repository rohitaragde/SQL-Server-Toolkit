------------------------- Unique and Non-Unique Indexes-----------------------------

/* Unique Index is used to enforce uniqueness of key values in the index.
Note:- By Default, Primary Key constraint creates a unique clustered index.
*/

---- creating table with PK which is by default clustered unique index----
create table tblEmployee0121
(  id int primary key,
   firstname nvarchar(50),
   lastname nvarchar(50),
   salary int,
   gender nvarchar(10),
   city nvarchar(50))

--- Checking index information using sp_helpindex and dropping 
 ---   index to verify the uniqueness of the index----

sp_helpindex tblEmployee0121

drop  index tblEmployee0121.PK__tblEmplo__3213E83F57AF315A

/*
It gives the following error shows that its an unique index.

Msg 3723, Level 16, State 4, Line 21
An explicit DROP INDEX is not allowed on index 
'tblEmployee0121.PK__tblEmplo__3213E83F57AF315A'.
It is being used for PRIMARY KEY constraint enforcement.

Completion time: 2024-08-19T19:03:13.3061231-04:00

Drop it manually using the GUI and now insert duplicate values
and since there no PK or index now it can insert duplicate rows.
Once you drop index pk gets dropped automatically*/

---- Insert Duplicate records once index dropped it will work successfully ---

insert into tblEmployee0121 values(1,'Mike','Sandoz',4500,'Male','New York')
insert into tblEmployee0121 values(1,'Sam','Menco',2500,'Male','London')


select * from tblEmployee012

/* Uniqueness is a property of an index and both clustered and non-clustered indexes
   can be unique.*/

create unique nonclustered index
UIX_tblEmployee0121_FirstName_LastName
on tblEmployee012(firstname,lastname)


sp_helpindex tblEmployee012

/* Difference between Unique Constraint and Unique Index
  There are no major differences between a unique constraint and a unique index.
  Infact when you add a unique constriant, a unique index gets created behind
  the scenes*/

---- If not mentioned creates unique non clustered index by default---

alter table tblEmployee0121
add constraint UQ_tblEmployee_City
unique clustered(city)


/* A unique constraint or index cannot be created on an existing table if the table
contains duplicate values on ey columns. To solve this, remove key columns from the
index definition or (delete or update) the duplicate values.
*/



