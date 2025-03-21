------------------------------------- Drop Login ---------------------------------------------

/*

The DROP LOGIN statement allows you to delete a SQL Server login account. 
Here’s the syntax of the DROP LOGIN statement:

DROP LOGIN login_name;

Code language: SQL (Structured Query Language) (sql)

In this syntax, you specify the login name that you want to delete after the DROP LOGIN keywords.

Note that you cannot drop a login while it’s signed in. 
And if a login owns a securable, server-level object, or SQL Server Agent job, 
you also cannot drop that login.

If a login account is mapped to database users and you drop a login,
these database users will become orphaned users.

*/

--------------- SQL Server DROP LOGIN statement example -------------------

----------- We’ll use the mastering_sql_server database in the following DROP LOGIN statement examples---


-------- Simple DROP LOGIN statement example -----

/* First, create a new login called jack with a password:*/

CREATE LOGIN jack
WITH PASSWORD = 'iOvT84xn.';

/* Second, drop the login jack using the DROP LOGIN statement:*/

DROP LOGIN jack;

/* 
The statement was completed successfully because the login jack has no dependency. 
Typically, you use this scenario when you create a login with the wrong intended name.
*/

-------------- Using the DROP LOGIN statement to remove a login that maps to a database user -------------

--------------- First, create a new login called joe with a password: --------------

CREATE LOGIN joe
WITH PASSWORD = 'NBgs23we$';

-------------- Second, create a new user for the login joe: -------------

CREATE USER joe
FOR LOGIN joe;

------------- Third, drop the login joe using the DROP LOGIN statement:--------------

DROP LOGIN joe;

/* The user joe becomes orphaned.
To get all orphaned users in the current database server, you use the following query:
*/

SELECT
  dp.type_desc,
  dp.sid,
  dp.name AS user_name
FROM sys.database_principals AS dp
LEFT JOIN sys.server_principals AS sp
  ON dp.sid = sp.sid
WHERE sp.sid IS NULL
AND dp.authentication_type_desc = 'INSTANCE';

/*
type_desc	sid	user_name
SQL_USER	0x6B1FAA5D5E9F12488BF8D36B83C78377	joe
*/

------------------------------- Resolve an orphaned user ---------------------------------

/* To resolve an orphaned user, you can recreate a missing login with the SID of the database user.
For example, the following statement creates a new login ocean with the SID of the user joe:
*/

CREATE LOGIN ocean
WITH PASSWORD = 'bNHXUYT321#',
	 SID = 0x6B1FAA5D5E9F12488BF8D36B83C78377;

/*
Now, the user joe can log in to the database server.

If you already have a login and want to map it with the orphaned user, 
you can use the ALTER USER statement. For example:

ALTER USER orphaned_user 
WITH LOGIN = login_name;
*/

/*

Use the DROP LOGIN statement to delete a login account from the SQL Server.
The DROP LOGIN cannot delete a login account that is logged in or owns a securable, server-level object, or SQL Server Agent job.
Drop a login that maps to database users will make these database users orphaned.

*/



