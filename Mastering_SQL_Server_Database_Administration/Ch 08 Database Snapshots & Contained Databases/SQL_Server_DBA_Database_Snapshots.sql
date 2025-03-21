------------------------------------- Database Snapshots ----------------------------------------

/*
A database snapshot is a read-only, static view of a database in an SQL Server instance. The database from which you create a snapshot is called a source database.

The database snapshot captures the state of the source database at the moment of the snapshot’s creation.

When you create a snapshot of a source database, the snapshot is empty

However, when you modify the source database, SQL Server copies the changes to the snapshot. 
In other words, the size of the snapshot grows as you make changes to the source database

A database can have multiple snapshots that persist until you explicitly drop them.

*/

--------------------------- SQL Server database snapshot features --------------------------------

/*

Here’s are the database snapshot features:

1) Database snapshots are dependent on the source databases. If the source databases are corrupted, 
the snapshots will be inaccessible.
2) Database snapshots reside on the same SQL Server instance as the source database.
3) Database snapshots operate at the data-page level. Before you make a change to a page of a source database,
SQL Server copies it from the source database to the snapshot. As the result,
the snapshot preserves the records of the source database as they existed when the snapshot was created.
4) It’s important to note that database snapshots cannot help protect against disk errors or
other types of corruption. In other words, snapshots are not substitutes for backups.

*/

------------------------------- Creating a database snapshot -----------------------------------

/* Let’s take a look at an example of creating a database snapshot. */

/* First, create a new database called HR with one table Employees: */


CREATE DATABASE HR;
GO

USE HR;

CREATE TABLE Employees (
  Id int IDENTITY PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL
);

INSERT INTO Employees (FirstName, LastName)
  VALUES ('John', 'Doe'),
  ('Jane', 'Doe');

---------------Second, use the CREATE DATABASE ... AS SNAPSHOT to create a snapshot of the HR database:---------------------

CREATE DATABASE HR_Snapshots 
ON ( NAME = HR, FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\snapshots\hr.ss')  
AS SNAPSHOT OF HR; 

--------- Third, delete a row with id 1 from the Employees table of the HR database:---------------

DELETE FROM Employees 
WHERE Id = 1;

------------------------- Fourth, query data from the Employees table: -----------------------------

SELECT * FROM Employees;

--------------------- Fifth, query data from the Employees of the HR_Snapshots database:------------------------

USE HR_Snapshots;

SELECT * FROM Employees;

/*
The output shows the data of the Employees table at the time we 
created the snapshot of the HR database.
*/

--------------------- Sixth, restore the HR database from the HR_Snapshots database:------------------------

USE master;

RESTORE DATABASE HR
FROM DATABASE_SNAPSHOT='HR_Snapshots';

-------------------- Seventh, query data from the Employees table of the HR database: --------------------------

USE HR;

SELECT * FROM Employees;

/* The output shows that the table has been recovered from the snapshot.*/

------------------------------- Why Database Snapshots -------------------------------------------

/*

Database snapshots can be useful for managing a test database. 
Before running a test, you can create a snapshot on the test database.
After each test run, you can use the database snapshot to quickly revert 
the database to its original state.

Database snapshots safeguard data against administrative error.
Before doing a major update to the database, you can create a snapshot. 
If you make a mistake, you can use the snapshot to recover the database by reverting 
the database to the snapshot. Reverting may be much faster than restoring from a backup.

Database snapshots can be used for reporting purposes. 
For example, you can create a snapshot of a database at month-end,
and keep updating the source database with the new transactions.
Since the snapshot stores the data at the time you created the snapshot,
you can create the month-end reports by querying the snapshot.

*/

/*

A database snapshot is a read-only, static view of a database.
Use the CREATE DATABASE ... AS SNAPSHOT statement to create a database snapshot.
Use the RESTORE DATABASE ... FROM DATABASE_SNAPSHOT to restore a database from a snapshot.

*/
