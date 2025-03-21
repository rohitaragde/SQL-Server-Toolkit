------------------------------------- Drop User -----------------------------------------

/*

The DROP USER statement allows you to delete a user from the current database.

Here’s the syntax of the DROP USER statement:

DROP USER [IF EXISTS] user_name;
Code language: SQL (Structured Query Language) (sql)


In this syntax, you specify the name of the user that you want to delete after 
the DROP USER keyword. If the user doesn’t exist in the current database, 
the DROP USER statement will fail.

To avoid this, you can use the IF EXISTS option.
The IF EXISTS option conditionally deletes the user if it already exists.

The DROP USER statement cannot delete a user that owns securables. 
To delete a user that owns securables, you need to:

Drop securables or transfer ownership of these securables to another user.
Drop the user.
The DROP USER statement also cannot drop the guest user. 
However, you can disable the guest user by revoking the CONNECT permission.

The following statement revokes the CONNECT permission from the guest user:

REVOKE CONNECT FROM GUEST;
Code language: SQL (Structured Query Language) (sql)
Note that you execute the above statement in any databases other than master or tempdb:

*/

------------------------  DROP USER statement example --------------------------------


----------------Using the DROP USER to delete a user in the current database example------------

/* First, create a new login jin with a password:*/

CREATE LOGIN jin
WITH PASSWORD ='uJIKng12.';

/* Second, create a new user and map it with the login jin:*/

CREATE USER jin
FOR LOGIN jin;

/* Third, drop the user jin from the current database: */

DROP USER IF EXISTS jin;

--------------------------- Drop a user that owns a securable example -------------------------

-------------------- First, create a new login called anthony with a password:---------------

CREATE LOGIN anthony
WITH PASSWORD ='uNMng78!';

-------------------- Second, create a new user for the login anthony: ------------------

CREATE USER tony
FOR LOGIN anthony;

------------------- Third, create a schema called report and grant authorization to the user tony:------------

CREATE SCHEMA report AUTHORIZATION tony;

---------- Fourth, connect to the SQL Server using the login anthony and create a table called daily_sales in the schema report:------------

USE [mastering_sql_server];
CREATE USER tony FOR LOGIN anthony;
ALTER ROLE db_owner ADD MEMBER tony;

USE mastering_sql_server;
CREATE TABLE report.daily_sales (
	Id INT IDENTITY PRIMARY KEY,
	Day DATE NOT NULL,
	Amount DECIMAL(10,2) NOT NULL DEFAULT 0
)

------- Fifth, switch the connection to the system administrator (sa) account and drop the user tony:---

drop user tony

/*
sg 15138, Level 16, State 1, Line 86
The database principal owns a schema in the database, and cannot be dropped.

Completion time: 2024-10-27T19:47:57.8950778-04:00
*/

/*

Because the user tony owns the schema report, the DROP USER statement cannot delete it.

To remove the user tony, you need to transfer the authorization of the schema report
to another user first. 

*/

/*For example, the following statement changes the authorization of 
the schema report to the user dbo:*/

ALTER AUTHORIZATION 
ON SCHEMA::report 
TO dbo;



-- If you execute the DROP USER statement to delete the user tony, you’ll see that it executes successfully:----

DROP USER tony;

/*

Use the DROP USER statement to delete a user in the current database.
If a user owns one or more securables, you need to transfer the ownership of the securables 
to another user before deleting the user

*/

