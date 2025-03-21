-------------------------------------- Alter Role -------------------------------------------

/*

The ALTER ROLE statement allows you to:

Rename a role
Add a member to a role
Remove a member from a role


The following ALTER ROLE ... WITH NAME renames a role:

ALTER ROLE role_name 
WITH NAME = new_name;

Code language: SQL (Structured Query Language) (sql)

In this syntax:

First, specify the name of the role after the ALTER ROLE keywords.
Second, specify the new role name in the WITH NAME clause.
To add a member to a role, you use the ALTER ROLE... ADD MEMBER statement:

ALTER ROLE role_name
ADD MEMBER database_principal;


Code language: SQL (Structured Query Language) (sql)
In this statement, the database_principal is a database user or a user-defined database role.
It cannot be a fixed database role or a server principal.

To remove a member from a role, you use the ALTER ROLE ... DROP MEMBER statement:

ALTER ROLE role_name
DROP MEMBER database_principal;

*/

------------------------------ SQL Server ALTER ROLE statement --------------------------------

/* We’ll use the mastering_sql_server database for the following examples. */

---------------- Using the SQL Server ALTER ROLE to rename a role ----------------------

/* First, create a new role called production: */

create role production;

/* Second, rename the role production to manufacturing using the ALTER ROLE statement:*/

alter role production with name=manufacturing;


------------------------- Using the SQL Server ALTER ROLE to add a member to a role ---------------------

------------------------------ First, create a new login called robert:-------------------

CREATE LOGIN robert 
WITH PASSWORD = 'Uikbm!#90';

----------------------------- Second, create a new user for the login robert: -------------------

CREATE USER robert 
FOR LOGIN robert;

------------------------ Third, add the user robert to the manufacturing role: --------------------

ALTER ROLE manufacturing 
ADD MEMBER robert;

/* The following query verifies that the user robert is a member of the role manufacturing: */

SELECT
  r.name role_name,
  r.type role_type,
  r.type_desc role_type_desc,
  m.name member_name,
  m.type member_type,
  m.type_desc meber_type_desc
FROM sys.database_principals r
INNER JOIN sys.database_role_members rm ON rm.role_principal_id = r.principal_id
INNER JOIN sys.database_principals m ON m.principal_id = rm.member_principal_id
WHERE r.name ='manufacturing';

---------------------  Using the SQL Server ALTER ROLE to remove a member from a role example----------------------

----- The following example uses the ALTER ROLE ... DROP MEMBER
----- to remove the user robert from the role manufacturing:-

ALTER ROLE manufacturing
DROP MEMBER robert;


/*

Use the ALTER ROLE ... WITH NAME to rename a role.
Use the ALTER ROLE ... ADD MEMBER to add a member to role.
Use the ALTER ROLE ... DROP MEMBER to remove a member from a role.

*/

