------------------------------------ SQL Server Full Backup ---------------------------------
/*

A full database backup backs up the whole database. It includes the following data:

The metadata of the database such as name, creation date, database options, file paths, and so on.
The used data pages of every data file.
Also, a full backup includes part of the transaction log. 
It represents the database at the time the backup is completed.

When doing a full backup, SQL Server may use a significant amount of disk I/O. 
Therefore, you should perform a full backup at a time when the workload is low e.g., at night.

In practice, you’ll use a full backup as a baseline for a more advanced backup strategy. 
For example, you can combine a full backup with transaction log backups.

Note that you must perform at least one full backup in order to perform other backup types 
like differential backups and transaction log backups.

*/

-- drop the mastering_sql_server database
USE master;
DROP DATABASE IF EXISTS mastering_sql_server;

-- create the HR database
CREATE DATABASE mastering_sql_server;
GO

-- create the People table
USE mastering_sql_server;

CREATE TABLE People (
  Id int IDENTITY PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL
);


INSERT INTO People (FirstName, LastName)
  VALUES ('John', 'Doe'),
  ('Jane', 'Doe'),
  ('Upton', 'Luis'),
  ('Dach', 'Keon');

SELECT * FROM People;


-------- Backup the Database -------

BACKUP DATABASE mastering_sql_server 
TO  DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\A.Bak'
WITH INIT,
NAME = 'Mastering-SQL-Server-Full Database Backup';

---- Read from the Backup File -----
RESTORE HEADERONLY   
FROM DISK ='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\A.Bak';

------ Restore the Database ------

use master;

drop database mastering_sql_server

RESTORE DATABASE mastering_sql_server
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\A.Bak'
WITH FILE = 1;

/* 
1 denotes first backup ( position of the backup file)
*/

------ Verify the data ----

use mastering_sql_server;

select * from People






















