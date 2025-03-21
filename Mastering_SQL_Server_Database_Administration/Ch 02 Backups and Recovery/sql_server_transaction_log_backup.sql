-------------------------------------- Transaction Log Backup ---------------------------------------
/*

When the recovery model of a database is FULL or BULK_LOGGED, you can back up the transaction log
of the database.Before creating a transaction log backup, you need to create at least one full backup.
After that, you can create any number of transaction log backups.

It’s a good practice to take transaction log backups more frequently to:
Minimize the data loss
Truncate the log files

Typically, you create a full backup occasionally such as weekly and 
create a series of differential backups at a shorter interval like daily.
Independent of the database backups, you create the transaction log at more frequent intervals 
such as hourly.

*/

----------------- Create a transaction log backup using T-SQL-----------------------------

/*
To create a transaction log backup, you use the BACKUP LOG statement:

BACKUP LOG database_name
TO DISK = path_to_backup_file
WITH options;

In this statement:

First, specify the name of the database to back up the transaction log.
The database must exist and be in an online state.
Second, specify the path to the backup log file. The path must exist in the filesystem.
Third, specify additional backup options in the WITH clause.

*/

----------------  SQL Server transaction log backup example ----------------------

------  First, Drop the HR Database --------


USE master;
DROP DATABASE IF EXISTS HR;

----- Second, create the new HR database------

CREATE DATABASE HR;
GO

-- Third, ensure the HR database is in the FULL recovery mode to perform a transaction log backup:--

ALTER DATABASE HR 
SET RECOVERY FULL;

---- Fourth, create the People table and insert a row:----

USE HR;
GO

CREATE TABLE People (
  Id int IDENTITY PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL
);

INSERT INTO People (FirstName, LastName)
VALUES ('John', 'Doe');

--------------  Fifth, create a full backup:------------------

BACKUP DATABASE HR 
TO  DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak'
WITH INIT,
NAME = 'HR-Full Database Backup';

-------------- Sixth, insert one more row into the People table -------------------

INSERT INTO People(FirstName, LastName)
VALUES ('Jane', 'Doe');

------------- Seventh, create the first transaction log backup: -------------------

BACKUP LOG HR
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak' 
WITH NAME = N'HR-Transaction Log Backup';

------------ Eighth, insert another row into the People table: ---------------------

INSERT INTO People(FirstName, LastName)
VALUES ('Upton', 'Luis');

----------- Ninth, create the second transaction log backup: ----------------------

BACKUP LOG HR
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak' 
WITH NAME = N'HR-Transaction Log Backup';

----------- Tenth, create the second full backup: -------------------

BACKUP DATABASE HR 
TO  DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak'
WITH NOINIT,
NAME = 'HR-Full Database Backup';

----------- Eleventh, insert another row into the People table: -------------

INSERT INTO People(FirstName, LastName)
VALUES('Dach', 'Keon');

-- Create the third transaction log backup to capture the final insert

BACKUP LOG HR
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak' 
WITH NAME = N'HR-Transaction Log Backup';

------------ Finally, view the backup file: -------------

RESTORE HEADERONLY   
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak';

-------------------------- Restore a database from a transaction log backup --------------------------

/*

To recover the database, you can restore the second full backup (position 4) 
and the last transaction log backup (position 5).
*/

--------------- First, drop the HR database: -------------------

USE master;
DROP DATABASE HR;

----------------  Second, restore the database from the second full backup: -----------------------

RESTORE DATABASE HR
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak'
WITH FILE = 4, NORECOVERY;

/*
In this statement, the number 4 specifies the second full backup in the backup file. 
The NORECOVERY puts the database in the restoring state so that you can restore the transaction 
log backup.
*/

------- Third, restore the transaction log backup using the RESTORE LOG statement:---------

RESTORE LOG HR
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak'
WITH FILE = 5, RECOVERY;

/*
In this statement, the number 5 indicates the last transaction log backup. 
The RECOVERY indicates that there is no further backup to restore. 
Hence, the database is accessible after the restoration completes.
*/

------------ Finally, switch the current database to HR and select data from the People table:----------

USE HR;
SELECT * FROM people;



/*
The People table has four rows indicating that you’ve successfully recovered the database 
from the full backup and transaction log backup.

To back up a transaction log, the recovery model of the database must be either FULL or BULK_LOGGED.
A transaction log backup contains a transaction log of a database.
Use the BACKUP LOG statement to back up the transaction logs.
Use the RESTORE LOG to recover the database from the transaction log backups.

*/


