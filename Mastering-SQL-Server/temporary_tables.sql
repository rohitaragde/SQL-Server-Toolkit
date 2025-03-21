----------------------------- Temporary Tables--------------------------------

---- 1st Connection-----
/*
Temporary tables are very similar to permanent tables. Permanent tables get
created in the database you specify, and remain in the database permanently 
until you delete(drop) them. On the other hand, temporary tables get created
in the TEMPDB and are automatically deleted, when they are no longer used.

Different types of Temporary Tables:-
a) Local Temporary Tables
b) Global Temporary Tables
*/

---- Create a Local Temporary Table------------

create table #PersonDetails(id int, name nvarchar(20));

--- Insert data into a local temporary table---
insert into #PersonDetails values(1,'Mike');
insert into #PersonDetails values(2,'John');
insert into #PersonDetails values(3,'Todd');

---- Retrieving data from a local temporary table---
select * from #PersonDetails;

---- Checking if the temporary table is created----
/* Temporary tables are created in TempDB. Query the
   sysobjects system table in TempDB. The name of the
   table is suffixed with a lot of underscores and a
   random number. For this reason you have to use the
   like operator in the query.
   */

   select name from tempdb..sysobjects 
   where name like '#personDetails%'


   /* 
   a) A local temporary table is available only for the connection
     that has created the table.
   b) A local temporary table is automatically dropped when the
      connection that has created it is closed.
   c) If the user wants to explicitly drop the temporary table
      he has to do using:-

	Drop table #PersonDetails*/


/*
If the temporary table is created inside the stored procedure, it gets dropped
automatically upon the completion of the stored procedure execution

It is also possible for different connections to create a local temporary table
with the same name. For example User1 and User2 both can create a local
temporary table with the same name #PersonDetails
But both will have different random numbers to differentiate
*/

create procedure uspCreateLocalTempTable
as
Begin

create table #PersonDetails(id int, name nvarchar(20))

insert into #PersonDetails values(1,'Mike')
insert into #PersonDetails values(2,'John')
insert into #PersonDetails values(3,'Todd')

select * from #PersonDetails
End

exec uspCreateLocalTempTable

/* Once the stored procedure is executed we can no 
longer access the data from the temporary table
as its dropped as soon asn we execute the stored procedure

select * from #PersonDetails

Msg 208, Level 16, State 0, Line 75
Invalid object name '#PersonDetails'.

Completion time: 2024-08-17T19:48:49.3028778-04:00
*/


/* 

Global Temporary Tables

To create a Global Temporary Table prefix the name of the table with 2 pound(##)
symbols.

create table ##EmployeeDetails(id int,name nvarchar(20))

Global Temporary Tables are visible to all the connections of the sql server and are only
destroyed when the last connection referencing the table is closed.

Multiple users, across multiple connections can have local temporary tables with the
same name, but a global temporary table name has to be unique, and if you inspect the
name of the global temp table, in the object explorer, there will be no random numbers
suffixed at the end of the tablename

*/

---- Creating a Global Temporary table----

create table ##EmployeeDetails(id int,name nvarchar(20))

---- Inserting Data into a Global Temporary table----

insert into ##EmployeeDetails values(1,'Mike')
insert into ##EmployeeDetails values(2,'John')
insert into ##EmployeeDetails values(3,'Todd')

------ Selecting Data from a Global Temporary Table---

select * from ##EmployeeDetails

/*

When you try to create a global temporary table with the same name
in a seperate window it gives the following error:-

Msg 2714, Level 16, State 6, Line 1
There is already an object named '##EmployeeDetails' in the database.

Completion time: 2024-08-17T20:04:06.5705007-04:00

*/

/*Difference

1) Local Temp Tables are prefixed with a single pound(#) symbol whereas the global
temp tables are prefixed with two pound(##) symbols.

2) SQL Server appends some random numbers at the end of the local temp tablename
  which is not done in case of global temporary tables

3) Local Temp Tables are only visible to that session of SQL Server which has
created it whereas Global temporary tables are visible to all SQL Server sessions.

4) Local Temp Tables are automatically dropped when the session that created the
temp tables is closed whereas the global temporary tables are destroyed when the 
last connection referncing the global temp table is closed.

*/



