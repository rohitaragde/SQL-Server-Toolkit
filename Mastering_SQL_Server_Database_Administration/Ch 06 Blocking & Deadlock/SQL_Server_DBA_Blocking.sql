------------------------------------ SQL Server Blocking-----------------------------------------

/*
A block ( or blocking block) occurs when two sessions attempt to update the same data concurrently.

The first session locks the data and the second session needs to wait for the first one to complete and release the lock.

As the result, the second session is blocked from updating the data. Once the first session completes, the second session resumes operation.

In general, blocking occurs when one session holds a lock on a resource and a second session attempts to acquire a conflicting lock type on the same resource.

Typically, the time in which the first session locks the data is very short. When it releases the lock, the second session can acquire its own lock on the resource and continue processing.

Blocking is an unavoidable and by-design feature of SQL Server with lock-based concurrency. It is normal behavior and doesn’t impact the server performance.
*/

------------------------ Kill sessions as database is already in use ---------------------------

------------------- Check for active connections using the database----------------------


SELECT spid, db_name(dbid) as DatabaseName, status, hostname, program_name, cmd, loginame
FROM sys.sysprocesses 
WHERE dbid = DB_ID('HR');

-- 1. First kill the specific connection
KILL 70;
GO

-- 2. Wait a moment
WAITFOR DELAY '00:00:02'
GO

-- 3. Set to single user
ALTER DATABASE HR SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

/*Drop the database and start working*/

/* To drop the database when working with open transaction active connections*/


USE master;
GO

ALTER DATABASE HR SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE HR;
GO

---------------------------------- SQL Server blocking example ------------------------------------

----------------- Basic Table creation and data insert without transaction------------------
DROP DATABASE IF EXISTS HR;
GO 

CREATE DATABASE HR;
GO

USE HR;

--drop table People

CREATE TABLE People (
  Id int IDENTITY PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL
);


INSERT INTO People (FirstName, LastName)
VALUES  ('Jane', 'Doe');


SELECT * FROM People;

/*
Id	FirstName	LastName
1	Jane	Doe
*/

/*
The People table has one row with Id 1.

First, begin a transaction and update the LastName of the row with Id 1 to 'Smith':
*/

-----------------------Basic Table creation and data insert without transaction-------------------------

BEGIN TRAN;

UPDATE People
SET LastName = 'Smith'
WHERE Id = 1;

select * from people;

--Commit;

/*
Id	FirstName	LastName
1	Jane	Smith
*/

/* we have started the transaction and updated lastname to Smith without commitiing or rolling back
the transaction*/


------------------------------ In another sql server window ------------------------------------

/* Note that we did not commit or rollback the transaction in the first session.

Second, create a new session. In the second session, update the LastName of the row with id 1 to ‘Brown’:

*/
---------------------- Blocked Query -----------------------------

/*
Second, create a new session. In the second session, 
update the LastName of the row with id 1 to ‘Brown’:
*/

use HR;

BEGIN TRAN;

UPDATE People
SET LastName = 'Brown'
WHERE Id = 1;

/* Now to see the output in the second window hit commit in the first window then you will see
that the second window is able to execute the update command and since its also an update
and now if you go back and check in the first it will also not be able to see the output so
come back in the second and run commit here as well to view the output in the first window.

In most cases, try to keep the SSMS in multi-user mode and one window with update and second
with just the select statement to avoid any complications.

*/

COMMIT; /* ( for both the transactions but run only below the begin transaction chain 
and not elsewhere).*/

--- To list all the processes that are currently connected to the SQL Server, you use the sp_who2 stored procedure. ----

sp_who2;

------------------- To set the SSMS to multi-user mode ------------------------------

-- First, check who's currently using the database
SELECT * FROM sys.dm_exec_sessions
WHERE database_id = DB_ID('HR')

-- If you need to force close all existing connections:
ALTER DATABASE HR SET SINGLE_USER WITH ROLLBACK IMMEDIATE

-- After your work is done, set it back to multi-user:
ALTER DATABASE HR SET MULTI_USER

------------------ To check for open transactions ------------------------------


SELECT @@TRANCOUNT as OpenTransactions;

IF @@TRANCOUNT > 0
    ROLLBACK TRANSACTION;
GO





