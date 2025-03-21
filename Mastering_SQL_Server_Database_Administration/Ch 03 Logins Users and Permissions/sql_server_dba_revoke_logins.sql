------------------------------------- Revoke Statement ---------------------------------------------
/*

The REVOKE statement removes previously granted permissions on a securable from a principal.

The following shows the syntax of the REVOKE statement:

REVOKE permissions
ON securable
FROM principal;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify one or more permissions in the REVOKE clause.
Second, specify a securable in the ON clause.
Third, specify a principle in the FROM clause.


*/

------------------------------- SQL Server REVOKE statement example ------------------------------

/*
To follow the example, you need to complete the GRANT statement example that creates 
the user peter and grant the SELECT, INSERT, and DELETE permissions 
on the People table to the user peter.

First, connect the SQL Server using the system administrator (sa) account and use 
the REVOKE statement to remove the DELETE permission on the People table from the user peter:

*/

REVOKE DELETE
ON People
FROM peter;

----- Second, connect to the SQL Server using the user peter and
----   issue the DELETE statement to verify the permission

DELETE FROM People;

/*
Msg 229, Level 14, State 5, Line 1
The DELETE permission was denied on the object 'People', database 'HR', schema 'dbo'.

Completion time: 2024-10-27T18:07:39.9934756-04:00
*/

/*It works as expected.*/

----  Third, select data from the People table:---

select * from people;

----- Fourth, remove the SELECT and UPDATE permissions on the People table from the user peter:-----

REVOKE SELECT, INSERT
ON People
FROM peter;

/*
Msg 229, Level 14, State 5, Line 1
The SELECT permission was denied on the object 'People', database 'HR', schema 'dbo'.

Completion time: 2024-10-27T18:09:25.3206269-04:00
*/

/*
The error indicates that the revoke was executed successfully.

Use SQL Server REVOKE statement to remove the previously granted permissions on a securable from a principal.

*/

