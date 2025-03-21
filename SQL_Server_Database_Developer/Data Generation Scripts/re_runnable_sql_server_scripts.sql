-------------------------------- Re-runnable SQL Server Scripts ------------------------------------
/* A re-runnable script is a script that when run more than once
will not throw errors.*/
/*
use [TUT]
create table tblEmployee0010
( id int identity primary key,
  Name nvarchar(100),
  Gender nvarchar(10),
  DateOfBirth DateTime);
*/
/*
if not exists (select * from information_schema.tables where table_name='tblEmployee0010')
Begin
create table tblEmployee0010
( id int identity primary key,
  Name nvarchar(100),
  Gender nvarchar(10),
  DateOfBirth DateTime)

Print 'Table TblEmployee successfully created'
End
Else
Begin
Print 'Table TblEmployee already exists'
End

-------------------------  Using Object_id --------------------------------------------------------

IF OBJECT_ID('tblEmployee0010') IS NULL
Begin
------- Create Table Script
    print 'Table tblEmployee created'
End
Else 
Begin
Print 'Table tblEmployee already exists'
End
*/
/*
IF OBJECT_ID('tblEmployee0010') IS NOT NULL
Begin
Drop table tblEmployee0010
End
create table tblEmployee0010
( id int identity primary key,
  Name nvarchar(100),
  Gender nvarchar(10),
  DateOfBirth DateTime);
*/

if not exists(select * from information_schema.columns
where column_name='EmailAddress' 
  and table_name='tblEmployee0010' and table_schema='dbo')
Begin
alter table tblEmployee0010
add EmailAddress nvarchar(50)
End
Else
Begin
Print 'Column EmailAddress already exists'
End










