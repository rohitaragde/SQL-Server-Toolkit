--------------------------------------- Roles ---------------------------------------

/*

A role is a group of permissions. Roles help you simplify permission management.
For example, instead of assigning permissions to users individually, 
you can group permissions into a role and add users to that role:

First, create a role.
Second, assign permissions to the role.
Third, add one or more users to the role.
SQL Server provides you with three main role types:

Server-level roles – manage the permissions on SQL Server-like changing server configuration.
Database-level roles – manage the permissions on databases like creating tables and querying data.
Application-level roles – allow an application to run with its own, user-like permissions.
For each type, SQL Server provides two types:

Fixed server roles: are the built roles provided by SQL Server. These roles have a fixed set of permissions.
User-defined roles: are the roles you define to meet specific security requirements.

*/

-----  First, create a new login called tiger: ----

CREATE LOGIN tiger
WITH PASSWORD='UyxIv.12';

----- Next, switch the current database to mastering_sql_server and create a user for the tiger login: -------

Use mastering_sql_server;

CREATE USER tiger
FOR LOGIN tiger;

/* Then, connect to the mastering_sql_server database using the user tiger. 
The user tiger can see the BikeStores database but cannot view any database objects.
*/

---- After that, add the user tiger to the db_datareader role:---

ALTER ROLE db_datareader
ADD MEMBER tiger;

/*
The db_datareader is a fixed database role.
The db_datareader role allows all the members to read data from all user tables and
views in the database. 
Technically, it’s equivalent to the following GRANT statement:
*/

GRANT SELECT 
ON DATABASE::mastering_sql_server
TO tiger;

/*
In this example, the DATABASE is a class type that indicates the securable which follows the :: is a database. The following are the available class types:

LOGIN
DATABASE
OBJECT
ROLE
SCHEMA
USER
*/

--- Finally, switch the connection to the user tiger and select data from the sales.orders table:---

SELECT * FROM sales.orders;

/* Worked successfully*/

-------------------------- Creating a user-defined role -------------------------

/*

The following example creates a new user and role, grants the permissions to the role,
and adds a user to the role.

First, set the current database to master and create a new login called mary:
*/

USE master;


CREATE LOGIN mary 
WITH PASSWORD='XUjxse19!';

/* Second, switch the current database to mastering_sql_server and create a new user called mary for the login mary:*/

USE mastering_sql_server;

CREATE USER mary 
FOR LOGIN mary;

/* Third, create a new role called sales_report in the BikeStores database:*/

CREATE ROLE sales_report;

/* In this example, we use the CREATE ROLE statement to create a new role. 
The sales_report is the role name.*/

/* Fourth, grant the SELECT privilege on the Sales schema to the sales_report:*/

GRANT SELECT 
ON SCHEMA::Sales 
TO sales_report;

/* Fifth, add the tiger user to the sales_report role:*/

ALTER ROLE sales_report
ADD MEMBER mary;

/*

Finally, connect to the mastering_sql_server database using the user mary. 
In this case, the user mary only can see the tables in sales schema. 
Also, the user mary can only select data from tables in this sales schema because 
the user is a member of the sales_report which has the SELECT privilege:

*/

/* We were able to view all the objects in the sales schema successfully */

/*

A role is a group of permissions.
Use the CREATE ROLE statement to create a new role.
Use the ALTER ROLE ... ADD MEMBER ... statement to add a user to a role.

*/









