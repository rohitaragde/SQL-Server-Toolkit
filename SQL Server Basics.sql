----------------------- SQL Server Basics----------------------------------------

------ Database Creation------

-- create database databasename---
   create database Sample2

/*
Whenever we create a database the following 2 files gets generated:-
a) .MDF File:- Data File (Contains Actual Data)
b) .LDF File:- Transaction Log File (Used to recover the database)
*/

-- Renaming a Database--

alter database Sample21 
Modify Name=Sample22

exec sp_renamedb 'Sample22','Sample23'

---- Deleting or Dropping a Database -----------

-- Drop database databasename

drop database Sample2;

/*
Dropping a database deletes the LDF and MDF files.You cannot drop a database if
its currently in use. You get an error stating- Cannot drop a database "Databasename"
bacause it is currently in use.

Msg 3702, Level 16, State 4, Line 25
Cannot drop database "Sample2" because it is currently in use.

Completion time: 2024-07-28T22:32:31.8395350-04:00


So, if other users are connected, you need to put the database in single user mode
and then drop the database.


Alter database databasename set single_user with rollback immediate

With Rollback Immediate option will rollback all incomplete transactions 
and closes the connection to the database.

Note:- System Databases cannot be dropped.

*/















