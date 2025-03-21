------------------------------- Grant Permissions -------------------------------------
/*
Once creating a user using the CREATE USER statement, 
the user doesn’t have any permissions on the database objects like tables, views, and indexes.

To allow the user to interact with the database objects,
you need to grant permissions to the user. 
For example, you can grant permissions so that the user can select data from a table.
To grant permissions to a user, you use the GRANT statement.

The GRANT statement allows you to grant permissions on a securable to a principal.
A securable is a resource to which the SQL Server authorization system regulates access.

For example, a table is a securable.
A principal is an entity that can request the SQL Server resource. 
For example, a user is a principal in SQL Server.
Here’s the basic syntax of the SQL Server GRANT statement:

GRANT permissions
ON securable TO principal;

*/

----------------------------- SQL Server GRANT example --------------------------

----------- First, create the HR database with a People table:-------------------

USE master;
GO

DROP DATABASE IF EXISTS HR;
GO

CREATE DATABASE HR;
GO

USE HR;

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

---------- Second, create a login with the name peter:-------------

CREATE LOGIN peter
WITH PASSWORD='XUnVe2di45.';

------------ Third, create a user peter in the HR database for the peter login:-------

USE HR;

CREATE USER peter
FOR LOGIN peter;

------------Fourth, connect the SQL Server using the peter user. -----------------------------

/*And you’ll see that the user peter can access the HR database but cannot view any tables.*/



------------ Fifth, switch to the system administrator connection and grant the SELECT permission to the user peter on the People table:-------------

GRANT SELECT 
ON People TO peter;

------------ Sixth, the user peter can see the People table and select data from it. For example:---

SELECT * FROM People;

--- However, the user peter cannot insert data into the People table:----

INSERT INTO People(FirstName, LastName)
VALUES('Tony','Blair');

/*
Msg 229, Level 14, State 5, Line 6
The INSERT permission was denied on the object 'People', database 'HR', schema 'dbo'.

Completion time: 2024-10-27T17:24:30.2873744-04:00
*/

--- Similarly, the user peter also cannot delete data from the People table:---

DELETE FROM People
WHERE Id = 1;

/*
Msg 229, Level 14, State 5, Line 16
The DELETE permission was denied on the object 'People', database 'HR', schema 'dbo'.

Completion time: 2024-10-27T17:24:55.0830731-04:00
*/

--- seventh, grant the INSERT and DELETE permissions on the People table to the user peter:----

GRANT INSERT, DELETE
ON People TO peter;

----eighth, switch to the user peter‘s connection and insert a new row into the People table:

INSERT INTO People(FirstName, LastName)
VALUES('Tony','Blair');

/*

(1 row affected)

Completion time: 2024-10-27T17:29:17.1883913-04:00
*/

/*

Now, the user peter can insert data into and delete data from the People table.


Use the GRANT statement to grant permissions on a securable to a principal.

*/







