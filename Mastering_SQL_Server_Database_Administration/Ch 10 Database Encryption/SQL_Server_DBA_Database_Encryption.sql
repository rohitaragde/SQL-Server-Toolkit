------------------------------- SQL Server Database Encryption --------------------------------------

/* TDE stands for Transparent data encryption. TDE allows you to encrypt SQL Server data files. 
This encryption is called encrypting data at rest.
In this session, we’ll create a sample database, encrypt it using TDE, 
and restore the database to another server.
*/

---------------- Create a test database ---------------------
----------------First, create a test database called test_db:------------------------

create database test_db;

----------------- Next, switch to the test_db: ------------------

use test_db;

---------------- Then, create the customers table: ---------------

create table customers(
	id int identity primary key,
	name varchar(200) not null,
	email varchar(200) not null
);

------------------------ After that, insert some rows into the customers table: ---------------------

insert into customers(name, email)
values('John Doe','john.doe@gmail.com'),
      ('Jane Doe','jane.doe@gmail.com');

----------------------- Finally, select the data from the customers table: ------------------------

select * from customers;

-------------------------- Encrypt the database -------------------------------

---------------------- First, switch to the master database: ------------------------

USE master;

---------------------- Second, create a master key: ----------------------

CREATE MASTER KEY ENCRYPTION
BY PASSWORD='kKyDQouFJKLB7ymBGmlq';

/* For the password, you should use a very strong one. */

-------------------------- Third, create a certificate protected by the master key: ---------------------

CREATE CERTIFICATE TDE_Cert
WITH SUBJECT='Database_Encryption';

------------------------ Fourth, switch to the test_db: ------------------------------

USE test_db;
GO

------------------------ Fifth, create the database encryption key: ----------------------

CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE TDE_Cert;

----------------------- Sixth, enable encryption for the test_db database: ---------------------

ALTER DATABASE test_db
SET ENCRYPTION ON;

---------------------- Seventh, check the encryption progress and status: ---------------------

SELECT 
	d.name,
	d.is_encrypted,
	dek.encryption_state,
	dek.percent_complete,
	dek.key_algorithm,
	dek.key_length
FROM sys.databases as d
INNER JOIN sys.dm_database_encryption_keys AS dek
	ON d.database_id = dek.database_id

/*
The is_ecrypted 1 means the database is encrypted.

The encryption state has one of three values:

0 – not encrypted
1 – the encryption is in progress
3 – the encryption was completed
*/

/* Eighth, back up the certificate. It’s important to note that you’ll need this certificate to restore the database to another database server:*/

use master

BACKUP CERTIFICATE TDE_Cert
TO FILE = 'c:\cert\TDE_Cert'
WITH PRIVATE KEY (
    file='c:\cert\TDE_CertKey.pvk',
    ENCRYPTION BY PASSWORD='kKyDQouFJKLB7ymBGmlq'
);

/*Note that the path c:\tde_cert must exist on the database server. 
It’s not the path on your local computer. */

----------------- Finally, backup the database. This step is optional. ----------------------

BACKUP DATABASE test_db
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\test_db.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'Test DB-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

----------------------------- Restore the database to another server ----------------------
---------------------- First, attempt to restore the database without the certificate: --------------

RESTORE DATABASE test_db 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\test_db.bak' 
WITH  FILE = 1,  NOUNLOAD,  STATS = 5;

/*

Msg 33111, Level 16, State 3, Line 1
Cannot find server certificate with thumbprint '0xA1456C76093E2E1E1AE0F1E1A57C29D9755C32C3'.
Msg 3013, Level 16, State 1, Line 1
RESTORE DATABASE is terminating abnormally.

*/


--- Second, create a certificate from the file and password that we generated in the encryption step:--
CREATE CERTIFICATE TDE_Cert  
FROM FILE = 'C:\cert\TDE_Cert'
WITH PRIVATE KEY   
(  
    FILE = 'C:\cert\TDE_CertKey.pvk',  
    DECRYPTION BY PASSWORD = 'kKyDQouFJKLB7ymBGmlq'  
);

------ Third, restore the database: ------------

RESTORE DATABASE test_db 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\test_db.bak' 
WITH  FILE = 1,  NOUNLOAD,  STATS = 5

/* Note since we are on local and not on database server the backup works and hence the 
  restore wont and once we are connected to a different server the restore will also work
  and we can more easily accomplish the certificate encryption and restroe steps*/

