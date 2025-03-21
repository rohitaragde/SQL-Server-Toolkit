---------------------------- Writing Re-runnable SQL Scripts -------------------------------

/* A re-runnable script is a script that when run more than once will not throw errors */

use [mastering_sql_server]
create table tblEmployee
(
  id int identity primary key,
  name nvarchar(100),
  gender nvarchar(10),
  DateOfBirth datetime
)

---------------------------------- Re-runnable Script -------------------------------------

/*
Msg 2714, Level 16, State 6, Line 6
There is already an object named 'tblEmployee' in the database.

Completion time: 2024-11-06T16:05:39.9830666-05:00
*/

/* 

To make this script re-runnable:-

1) Check for the existence of the table
2) Create the table if it does not exist
3) Else print a message stating the table already exists*/

use [mastering_sql_server]
if not exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='tblEmployee')
Begin
      create table tblEmployee
	  (
	     id int identity primary key,
		 nname nvarchar(100),
		 gender nvarchar(10),
		 DateOfBirth datetime
	  )
	  print 'Table tblEmployee successfully created'
End
Else 
Begin
     print 'Table tblEmployee already exists'
End 

/*
if table does not exists it prints:-

Table tblEmployee successfully created

Completion time: 2024-11-06T18:51:50.0747683-05:00

and if the table already exists it prints:-

Table tblEmployee already exists

Completion time: 2024-11-06T18:52:22.4846399-05:00

*/

---------------------------------- Additional ways to check for existence -----------------------------

/* Sql Server built in function OBJECT_ID() can also be used to check for the existence */

if OBJECT_ID('tblEmployee') IS NULL 
Begin
   ----------- Create Table Script ------------
   print 'Table tblEmployee created'
End 
Else 
Begin 
   print 'Table tblEmployee already exists'
End 

------ Drop(if the table already exists) and recreate --------

----- return the ID of the object -----

use [mastering_sql_server]
select OBJECT_ID('tblEmployee') 

use [mastering_sql_server]
if OBJECT_ID('tblEmployee') is NOT NULL 
Begin 
   Drop table tblEmployee 
End 
create table tblEmployee 
(
  id int identity primary key,
  nname nvarchar(100),
  gender nvarchar(10),
  DateOfBirth datetime
)

----------------------------------- Column Example ---------------------------------

--------------- This script is not re-runnable because, if the column exists we get a error -------------
use [mastering_sql_server]
alter table tblEmployee 
add EmailAddress nvarchar(50)

/* when we run the script the first time it runs without any error but when we run it again
we get this error:-

Msg 2705, Level 16, State 4, Line 101
Column names in each table must be unique.
Column name 'EmailAddress' in table 'tblEmployee' is specified more than once.

Completion time: 2024-11-06T19:12:01.9576733-05:00

*/


--------------- to make this script re-runnable, check for the column existence -------------------

use [mastering_sql_server]
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME='EmailAddress' and 
TABLE_NAME='tblEmployee' and TABLE_SCHEMA='dbo')
Begin 
    Alter TABLE tblEmployee 
	ADD EmailAddress nvarchar(50) 
End 
Else 
Begin 
     print 'Column EmailAddress already exists'
End 

----------- Col_length() function can also be used to check for the existence of a column -----------

if col_length('tblEmployee','EmailAddress') is not null 
Begin 
    print 'Column already exists'
End
Else 
Begin 
    print 'Column does not exist'
End 


















