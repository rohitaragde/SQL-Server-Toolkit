------------------------------------ Alter Login -------------------------------------------

/*
To change the properties of a login account, you use the ALTER LOGIN statement.
*/

---- Before using the ALTER LOGIN statement, let’s create a new login first:----

CREATE LOGIN bobcat
WITH PASSWORD = 'Mou$eY2k.';

--------------------- Disable a login ----------------------------

----  The following ALTER LOGIN statement disables a login account:

ALTER LOGIN login_name
DISABLE;


--- For example, the following statement disables the login bobcat:

ALTER LOGIN bobcat
DISABLE;

/*
TITLE: Connect to Server
------------------------------

Cannot connect to ROHIT.

------------------------------
ADDITIONAL INFORMATION:

Login failed for user 'bobcat'. Reason: The account is disabled. (Microsoft SQL Server, Error: 18470)

*/

/* Once disabled, you cannot use the bobcat to log in to the SQL Server. */

---------------------------------- Enable a disabled login ---------------------------------

--- The following ALTER LOGIN statement enables a login:

ALTER LOGIN bobcat
ENABLE;

/* Once enabled, you can use bobcat to log in to the SQL Server.*/

---------------------------------- Rename a login -----------------------------------

/* The following ALTER LOGIN ... WITH NAME change the name of a login to a new one:

ALTER LOGIN login_name 
WITH NAME = new_name;
*/

-- For example, the following statement changes the login bobcat to lion:

ALTER LOGIN bobcat
WITH NAME = lion1;

--------------- Change the password of a login --------------------------

/* To change the password of a login, you use the ALTER LOGIN ... WITH PASSWORD statement:

ALTER LOGIN login_name
WITH PASSWORD = new_password;

*/

-- For example, the following statement changes the password of the login lion to a new one:

ALTER LOGIN lion1
WITH PASSWORD = 'Hor$e2022.';

/* If a login account is currently logged in and you do not have the ALTER ANY LOGIN permission,
you need to specify the OLD_PASSWORD option:

ALTER LOGIN login_name
WITH PASSWORD = new_password 
 OLD_PASSWORD = old_password;

*/

ALTER LOGIN lion1
WITH PASSWORD = 'Deer$2022.' 
	 OLD_PASSWORD = 'Hor$e2022.';

/*
If you migrate the login accounts from a legacy database and want 
to reuse the old password, you can use the hashed password. For example:

ALTER LOGIN legacy
WITH PASSWORD=0x0200B6E66AFC7FF8B4EBCB553B3F95C4A566E724CC2C6265C0C2663DA89C96C38B230C2468DC46E11A3AA32522D3E074D91D9C5A32A9C8535A9DCF3EB49AB233E340C2345EF7
HASHED;

*/



--------------------------- Unlock a login -----------------------------------

/* If you enforce a password policy on a login
and the login account failed a number of times, the login can be locked.
*/

--------- To unlock a login account, you use the ALTER LOGIN ... UNLOCK statement:---------

/*ALTER LOGIN login_name
WITH PASSWORD=password
UNLOCK;
*/

ALTER LOGIN lion1
WITH PASSWORD='Deer$2023.'
UNLOCK;

/*
Use the ALTER LOGIN statement to change the properties of a login account.
*/












