-------------------------------------- Differential Backup -----------------------------------------
/*

A differential backup is based on the most recent full backup. In other words, you only can create a differential backup once you have at least one full backup.

A differential backup captures all the changes since the last full backup. And that full backup is called the base for the differential backup.
*/

/*

A differential backup has the following benefits in comparison with a full backup:

Speed – creating a differential backup can be very fast in comparison with creating a
full backup because a differential backup captures only data that has changed since the 
last full backup.
Storage – a differential backup requires less storage than a full backup.
Less risk of data loss – since a differential backup needs less storage,
you can take differential backups more frequently, which decreases the risk of data loss.

However, restoring from a differential backup requires more time than restoring
from a full backup because you need to restore from at least two backup files:

First, restore from the most recent full backup.
Then, restore from a differential backup.

*/

------------------------------- Creating a Differential Backup ----------------------------------

/*
BACKUP DATABASE statement
To create a differential backup, you use the BACKUP DATABASE statement with the option
DIFFERENTIAL like this:

BACKUP DATABASE database_name
TO DISK = path_to_backup_file
WITH DIFFERENTIAL;

*/

--------------------------Create differential backups example------------------------------------

-------------------------- Firstly, Drop the HR Database --------------------

USE master 
DROP DATABASE IF EXISTS HR;

------------------- Second, create the HR database with the People table that has one row:---


CREATE DATABASE HR;
GO

USE HR;
GO

CREATE TABLE People (
  Id int IDENTITY PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL
);

INSERT INTO People (FirstName, LastName)
VALUES ('John', 'Doe');


select * from People

------------------- Create a full Backup of the HR database --------------------------

BACKUP DATABASE HR 
TO  DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak'
WITH INIT,
NAME = 'HR-Full Database Backup';

/*The first full backup contains one row with id 1.
Now, insert one more row into the People table:
*/

--------------- Insert one more row into the People Table --------------------

INSERT INTO People(FirstName, LastName)
VALUES ('Jane', 'Doe')

select * from People 

-------------- Create the first differential backup of the HR database:----------

BACKUP DATABASE HR
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak' 
WITH  DIFFERENTIAL , 
NAME = N'HR-Differential Database Backup';

/*
The backup file now has two backups: one full backup and one differential backup.
The different backup contains the row with id 2.
*/

---- Now, insert one more row into the People table:---

INSERT INTO People(FirstName, LastName)
VALUES ('Dach', 'Keon');

select * from People 

----------------------------- Create a Second Differential Backup ------------------------------

BACKUP DATABASE HR
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak' 
WITH  DIFFERENTIAL , 
NAME = N'HR-Differential Database Backup';

/*
The second differential backup contains rows with id 2 and 3 because
it captures the changes since the last full backup
*/

----------------------- Create a Second Full Backup --------------------------

BACKUP DATABASE HR 
TO  DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak'
WITH NOINIT,
NAME = 'HR-Full Database Backup';

/*
The second full backup contains the rows with id 1, 2, and 3.
*/

------------- Now, Insert one more row into the People table ---------------

INSERT INTO People(FirstName, LastName)
VALUES('Dach', 'Keon');

select * from people 

------------- Create a third differential Backup ---------------

BACKUP DATABASE HR
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak' 
WITH  DIFFERENTIAL , 
NAME = N'HR-Differential Database Backup';

/*
The third differential backup contains the row with id 4.
*/

----------------------Finally, examine the backup file:---------------------------

RESTORE HEADERONLY   
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak';

----------------- Restore a differential backup--------------------------

/*
To restore the HR database from the backup file, 
you can restore the second full backup and the last differential backup.
*/

-- First, Drop the HR database:--

USE master;
DROP DATABASE IF EXISTS HR;

-- Second, restore the HR database from the second full backup:---

RESTORE DATABASE HR
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak'
WITH FILE = 4, NORECOVERY;

/*

Note that the file number of the second full backup is 4. 
The NORECOVERY option places the database in the restoring state.

If you use the SSMS, the HR database will look like this:

HR (Restoring...)
Code language: SQL (Structured Query Language) (sql)
In the restoring state, the database is not accessible.

In other words, use the NORECOVERY option if you have more backups to restore.
However, if you have no further backup to restore, you need to use the RECOVERY option instead.

*/

----- Third, restore the HR database from the last differential backup:---------

RESTORE DATABASE HR
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\hr.bak'
WITH FILE = 5, RECOVERY;

/* The FILE=5 instructs the SQL Server to use the last differential backup. 
And the RECOVERY option indicates that you have no further backups to restore.
*/

---- Finally, select data from the People table in the HR database:----

USE HR;
SELECT * FROM people;

/*
If you see 4 rows from the output, you have been successfully restored the database 
from a differential backup.

A differential backup captures the changes since the most recent full backup. 
And a differential backup is always based on a full backup.

Use the BACKUP DATABASE statement with the DIFFERENTIAL option to create a differential backup.

Always restores from the full backup first before restoring from a differential backup.

*/




