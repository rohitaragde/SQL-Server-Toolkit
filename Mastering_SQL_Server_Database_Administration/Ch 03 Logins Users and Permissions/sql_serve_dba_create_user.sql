--------------------------------- Create User ------------------------------------

/*

The SQL Server CREATE USER statement allows you to add a user to the current database.

The following shows the basic syntax of the CREATE USER statement:

CREATE USER username 
FOR LOGIN login_name;

Code language: SQL (Structured Query Language) (sql)

In this syntax:

First, specify the name of the user after the CREATE USER keywords.
Second, specify the login_name for the user. The login name must be valid on the server. 
To create a login, you use the CREATE LOGIN statement.

*/


---------------------- SQL Server CREATE USER statement ----------------------------

-- First, create a new login called alex with the password 'Uvxs245!':

CREATE LOGIN alex
WITH PASSWORD='Uvxs245!';

-- Second, switch the current database to the mastering_sql_server:

use mastering_sql_server;

-- Third, create a user with the username alex that uses the alex login:

CREATE USER alex
FOR LOGIN alex;

/*

If you use SSMS, you can see the user alex under mastering_sql_server > Security > Users list

The user alex can connect to SQL Server using the alex login’s password and
accesses the mastering_sql_server database. 
However, the user alex cannot access any tables and other
database objects in the mastering_sql_server database.

To do that, you need to add the user alex to the database roles or grant it permissions.

Use the CREATE USER statement to add a user to the current database.

*/


