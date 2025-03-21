-------------------------------------- Create Role ----------------------------------------

/*

A role is a database-level securable, which is a group of permissions.
To create a new role, you use the CREATE ROLE statement:

CREATE ROLE role_name 
[AUTHORIZATION owner_name];
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the role after the CREATE ROLE keywords.
Second, specify the ower_name in the AUTHORIZATION clause. The owner_name is a database user or role that owns the new role. If you omit the AUTHORIZATION clause, the user who executes the CREATE ROLE statement will own the new role.
Note that the owner of the role and any member of an owning role can add or remove members of the role.

Typically, you create a new role, grant the permissions to it using the GRANT statement, and add members to the role using the ALTER ROLE statement.

*/

------------------------  Creating a new role ------------------------------

------------- First, create the new login called james in the master database:---------------

CREATE LOGIN james 
WITH PASSWORD = 'Ux!sa123ayb';


------------------ Next, create a new user for the login james: ---------------------

CREATE USER james 
FOR LOGIN james;

------------------- Then, create a new role called sales: -----------------------

CREATE ROLE sales;

/* After that, grant the SELECT, INSERT, DELETE, and UPDATE privileges on the sales schema to the sales role:*/

GRANT SELECT, INSERT, UPDATE, DELETE 
ON SCHEMA::sales
TO sales;

/* Finally, add the user james to the sales role:*/

ALTER ROLE sales
ADD MEMBER james;

------------------ Creating a new role owned by a fixed database role example --------------------------\

/* The following example uses the CREATE ROLE statement to create a new role owned by the db_securityadmin fixed database role:*/


CREATE ROLE sox_auditors
AUTHORIZATION db_securityadmin;

--------------------------------------- Examining the roles ------------------------------------

/*
The roles and their members are visible in the sys.database_principals and
sys.database_role_members views.

The following shows the information on the sales and sox_auditors roles:
*/

SELECT
  name,
  principal_id,
  type,
  type_desc,
  owning_principal_id
FROM sys.database_principals
WHERE name in ('sales', 'sox_auditors');


/* Use the SQL Server CREATE ROLE statement to create a new role in a database.*/

