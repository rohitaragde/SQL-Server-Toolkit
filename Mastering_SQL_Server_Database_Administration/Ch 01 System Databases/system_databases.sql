use mastering_sql_server

-------------------------------- System Databases -------------------------------------------------

/* 
By default, SQL Server provides you with four main systems databases:

master
msdb
model
tempdb



1) master
The master database stores all the system-level information of an SQL Server instance, which includes:

a)Server configuration settings
b) Logon accounts
c) Linked servers information
d) Startup stored procedure
e) File locations of user databases

If the master database is unavailable, the SQL Server cannot start. When you work with the
master database, you should:

a)First, always have a current backup of the master database. If the master database is corrupted,
you can restore it from the backup.

b) Second, back up the master database as soon as possible after the following operations:

1) Creating, modifying, and dropping any database
2) Changing the server configurations
3) Update the logon accounts including adding, removing, and modifying
4) Third, do not create user objects in the master database.

Finally, do not set the TRUSTWORTHY database property of the master to ON.

Note that if the TRUSTWORTHY database property is ON, the SQL Server will trust the database 
and the contents within it, which increases the security risk. By default, the TRUSTWORTHY is OFF. 
More information on the TRUSTWORTHY option.

2) msdb
The msdb is used by the SQL Server Agent for scheduling jobs and alerts. 
Also, it stores the history of the SQL Agent jobs.

The msdb supports the following:

a) Jobs & alerts
b) Database Mail
c) Service Broker
d) And the backup & restore history for the databases



3) model
SQL Server uses the model database as the template for creating other databases.
When you create a new database, SQL Server copies the contents of the model database
including database options to the new database.
If you modify the model database, all databases that you create afterward will take these changes.
Whenever SQL Server starts, it creates the tempdb from the model database. 
Therefore, the model database must always exist on the SQL Server.

4)tempdb
The tempdb database stores temporary user objects that you explicitly create like temporary tables
and table variables.Also, the tempdb stores the internal objects that the database engine creates.
For example, the tempdb database stores the immediate sort results for running the queries that 
include the ORDER BY clause.SQL Server recreates the tempdb database every time it starts. 
Since the tempdb is non-permanent storage, you cannot back it up or restore it.

