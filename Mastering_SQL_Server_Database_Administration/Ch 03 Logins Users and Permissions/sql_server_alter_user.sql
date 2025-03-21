------------------------------------- Alter User ---------------------------------------------

/*
The ALTER USER statement allows you to modify the properties of an existing user. 

The ALTER USER statement allows you to:

Change the name of a user to the new one.
Change the default schema of a user to another.
Map a user to another login account

*/

--------------------------  Rename a user -----------------------------

---------------- To rename a user, you use the ALTER USER ... WITH NAME statement:------------------

/*
ALTER USER user_name
WITH NAME new_name;
*/

----------------- First, create a new login called zack:------------------

CREATE LOGIN zack 
WITH PASSWORD = 'Zu$c3suik.';

---------------- Second, create a user for the same login: ----------------

CREATE USER zack
FOR LOGIN zack;

--------------- Third, change the name of the user zack to zachary:----------

ALTER USER zack
WITH NAME = zachary;

------------------------------ Change the default schema ------------------------------------

/*To change the default schema of a user to another, 
you use the ALTER USER .. WITH DEFAULT_SCHEMA statement:

ALTER USER user_name
WITH DEFAULT_SCHEMA = new_schema;
*/

---- For example, the following statement changes the default schema of the user zachary to sales----

ALTER USER zachary
WITH DEFAULT_SCHEMA = sales;

------------------- Map the user with another login account --------------------------

/* To map the user with another login account, you use following ALTER USER ... WITH LOGIN statement:

ALTER USER user_name
WITH LOGIN = new_login;

*/

/* For example, the following statements create a new login and map it with the user zachary */

CREATE LOGIN zachary
WITH PASSWORD = 'Na%c8suik#';

ALTER USER zachary
WITH LOGIN = zachary;

---------------------------------- Changing several options at once -------------------------------

/* The following statement changes the name, default schema, and login of the user zachary:*/

ALTER USER zachary
WITH NAME = zack,
     LOGIN = zack,
     DEFAULT_SCHEMA = production;


/* Use the ALTER USER statement to change the name of a user,
map it with a new login and change the default schema.
*/







