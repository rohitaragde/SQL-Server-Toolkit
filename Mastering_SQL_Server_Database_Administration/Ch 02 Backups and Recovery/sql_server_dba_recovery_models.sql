----------------------------------------- Database Recovery Model --------------------------------

/* A recovery model is a property of a database. A recovery model controls the following:

How SQL Server logs the transactions for the database.
Whether the transaction log of the database requires backing up.
What kind of restore operations are available for restoring the database.
SQL Server provides you with three recovery models:

Simple
Full
Bulk-logged

When you create a new database, SQL Server uses the model database to set the default recovery model of the new database.



*/


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

-- Viewing the recovery model of a database ---

SELECT
  name,
  recovery_model_desc
FROM master.sys.databases
WHERE name = 'mastering_sql_server';

-- To view the recovery model of all the databases in the current server ---

SELECT
  name,
  recovery_model_desc
FROM master.sys.databases
ORDER BY name;


----Changing the recovery model----
----To change the recovery model to another, you use the ALTER DATABASE following statement:

/*
ALTER DATABASE database_name 
SET RECOVERY recovery_model;
*/

/*

SIMPLE recovery model
In the SIMPLE recovery model, SQL Server deletes transaction logs from the transaction log files
at every checkpoint. This results in relatively small transaction log files.
Also, in the SIMPLE recovery model, the transaction logs do not store the transaction records. 
Therefore, you won’t able to use advanced backup strategies to minimize data loss.
In practice, you use the SIMPLE recovery model for the database that could be reloaded 
from other sources such as databases for reporting purposes.

FULL recovery model
In the FULL recovery model, SQL Server keeps the transaction logs in the transaction log files 
until the BACKUP LOG statement is executed. In other words, the BACKUP LOG statement deletes
the transaction logs from the transaction log files.If you don’t run the BACKUP LOG statement regularly,
SQL Server keeps all transaction logs in the transaction log files until the transaction log files 
are full and the database is inaccessible. This is why you need to run the BACKUP LOG statement at a
regular interval to keep the transaction log files from being full.In short, the FULL recovery model 
allows you to restore the database at any point in time.

BULK_LOGGED recovery model

The BULK_LOGGED recovery model has almost the same behaviors as the FULL recovery model except for
bulk-logged operations. For example, the BULK INSERT of flat files into tables are described briefly 
in the transaction log files.The BULK_LOGGED recovery model doesn’t allow you to restore the database
at any point in time. A practical scenario of the BULK_LOGGED recovery is as follows:

a) Before periodical data load, set the recovery model to BULK_LOGGED
b) Load the data into the database
c) Set the recovery model back to FULL after completing the data load
d) Back up the database

*/





