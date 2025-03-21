-------------------------------------------- Drop Role -------------------------------------------

/*

The DROP ROLE statement removes a role from the current database. Here’s the syntax of the DROP ROLE statement:

DROP ROLE [IF EXISTS] role_name;
Code language: SQL (Structured Query Language) (sql)

In this syntax, you specify the name of the role that you want to remove after the DROP ROLE keywords.

The IF EXISTS clause is optional and has been available since SQL Server 2016. The IF EXISTS conditionally removes the role only if it already exists.

The DROP ROLE statement cannot remove a role that owns securables. To drop a role that owns the securables, you need to first transfer ownership of those securables and then drop the role from the database.

The DROP ROLE statement cannot remove a role that has members. To remove a role that has members, you need to remove the members from the role before dropping it.

The DROP ROLE statement cannot remove fixed database roles like db_datareader, db_datawriter, db_securityadmin, etc.

*/

----------------------------- SQL Server DROP ROLE -----------------------------------

/* The following example uses the DROP ROLE statement to drop the sox_auditors role
from the mastering_sql_server database: */

DROP ROLE IF EXISTS sox_auditors;

/* Since the role sox_auditors has no member, the statement executes successfully.*/

---------------------------  Remove a role that has members example ---------------------------

/* First, use the DROP ROLE statement to remove the role sales from the database:*/

DROP ROLE sales;

/* Since the role sales has members, SQL Server issues the following error:*/

/* Msg 15144, Level 16, State 1, Line 35
The role has members. It must be empty before it can be dropped.

Completion time: 2024-10-27T21:48:12.8023769-04:00

*/

/* Second, to find the members that belong to the role sales, you use the following statement:*/

SELECT
  r.name role_name,
  r.type role_type,
  r.type_desc role_type_desc,
  m.name member_name,
  m.type member_type,
  m.type_desc member_type_desc
FROM sys.database_principals r
INNER JOIN  sys.database_role_members  rm on rm.role_principal_id = r.principal_id
INNER JOIN sys.database_principals m on m.principal_id = rm.member_principal_id
WHERE r.name ='sales';

/* The output shows that the role sales has one member which is the user james.*/

------------Third, remove the user james from the role sales using the ALTER ROLE... DROP MEMBER statement:----------------------------

ALTER ROLE sales
DROP MEMBER james;

----------- Finally, remove the sales roles using the DROP ROLE statement: -----------

DROP ROLE sales;

/*
Use the DROP ROLE statement to remove a role from the current database
*/





