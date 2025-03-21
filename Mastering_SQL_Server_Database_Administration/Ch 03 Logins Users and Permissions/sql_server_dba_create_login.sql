---------------------------------- Create Login ----------------------------------------

/*

Before creating a user that accesses the databases in an SQL Server, you need to follow these steps:

First, create a login for SQL Server.
Second, create a user and map the user with the login.
To create a login, you use the CREATE LOGIN statement. The following shows the basic syntax of the CREATE LOGIN statement:


CREATE LOGIN login_name 
WITH PASSWORD = password;

In this syntax:

First, specify the login name after the CREATE LOGIN keywords.
Second, specify the password in the WITH PASSWORD clause.

Internally, SQL Server stores the hash of the password using SHA-512. 
When you migrate a database, you can reuse the hashed passwords of the logins
from the legacy database in the new database.

To create a login with a hashed password, 
you specify the hashed password with the HASHED keyword like this:

CREATE LOGIN login_name 
WITH PASSWORD = hashed_password HASHED;

For security reasons, you should use the hashed password for database migration purposes only

*/

---------------------------  SQL Server CREATE LOGIN statement example -------------------------------


CREATE LOGIN Ross
WITH PASSWORD='Ebe2di68.';

/*

The login Ross can log in to the SQL Server, and view the database names,
but cannot access any databases.
*/

/*To view all the logins of an SQL Server instance, you use the following query:*/

SELECT
  sp.name AS login,
  sp.type_desc AS login_type,
  CASE
    WHEN sp.is_disabled = 1 THEN 'Disabled'
    ELSE 'Enabled'
  END AS status,
  sl.password_hash,
  sp.create_date,
  sp.modify_date
FROM sys.server_principals sp
LEFT JOIN sys.sql_logins sl
  ON sp.principal_id = sl.principal_id
WHERE sp.type NOT IN ('G', 'R')
ORDER BY create_date DESC;

-----------------------------  SQL Server CREATE LOGIN statement options -------------------------

---The CHECK_POLICY option ----
/*
The CHECK_POLICY option allows you to specify that the Windows password 
policies of the server on which the SQL Server is running should be applied to the login. 
The CHECK_POLICY can be ON or OFF. Its default value is ON.
The following shows the CREATE LOGIN statement with the CHECK_POLICY option:

CREATE LOGIN login_name
WITH PASSWORD = password, 
CHECK_POLICY = {ON | OFF};

Note that the CHECK_POLICY option is applied to SQL Server logins only

*/

----- The CHECK_EXPIRATION option ----
/*
The CHECK_EXPIRATION option determines whether the password expiration policy
should be enforced on this login. The CHECK_EXPIRATION can be ON or OFF. 
The default value is OFF.

The following shows the CREATE LOGIN statement with the CHECK_EXPIRATION option:

CREATE LOGIN login_name
WITH PASSWORD = password, 
CHECK_EXPIRATION = {ON | OFF};

Note that the CHECK_EXPIRATION option is applied to SQL Server logins only.

*/

---The MUST_CHANGE option ---

/*

To prompt the users for a new password the first time they log in,
you use the MUST_CHANGE option. When you use the MUST_CHANGE option, 
the CHECK_POLICY and CHECK_EXPIRATION must be ON. Otherwise, the statement will fail.

CREATE LOGIN login_name
WITH PASSWORD = password MUST_CHANGE,
     CHECK_POLICY=ON,
     CHECK_EXPIRATION=ON;

CREATE LOGIN alice
WITH PASSWORD = 'UcxSj12.' MUST_CHANGE,
     CHECK_POLICY=ON, 
     CHECK_EXPRIATION=ON;

In this example, SQL Server will prompt the user who uses the alice login name
for a new password the first time the user logs in.

Note that the MUST_CHANGE option is applied to SQL Server logins only.

*/


------------------- Creating a login from a Windows domain account -------------------------------
/*
To create a login from a Windows domain account, you use the following statement:

CREATE LOGIN domain_name\login_name
FROM WINDOWS;

CREATE LOGIN sqlservertutorial\peter
FROM WINDOWS;

Note that the sqlservertutorial\peter windows domain account must exist.

*/



