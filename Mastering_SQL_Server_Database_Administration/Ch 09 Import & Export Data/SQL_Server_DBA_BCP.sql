---------------------------------------- SQL Server BCP --------------------------------------------

/*
BCP stands for Bulk Copy Program. BCP is a command-line tool that uses the bulk copy program API
that allows you to bulk-copy data between an SQL Server instance and a file.

In generally, BCP allows you to:

Bulk export data from a table into a data file
Bulk export data from a query into a data file
Bulk import data from a data file into a table
Generate format files

*/

--------------------------- To launch the BCP program, you open the command line and use the bcp command.------------

----- (in command prompt windows)---------------

bcp
/*

C:\Users\rohit>bcp
usage: bcp {dbtable | query} {in | out | queryout | format} datafile
  [-m maxerrors]            [-f formatfile]          [-e errfile]
  [-F firstrow]             [-L lastrow]             [-b batchsize]
  [-n native type]          [-c character type]      [-w wide character type]
  [-N keep non-text native] [-V file format version] [-q quoted identifier]
  [-C code page specifier]  [-t field terminator]    [-r row terminator]
  [-i inputfile]            [-o outfile]             [-a packetsize]
  [-S server name]          [-U username]            [-P password]
  [-T trusted connection]   [-v version]             [-R regional enable]
  [-k keep null values]     [-E keep identity values][-G Azure Active Directory Authentication]
  [-h "load hints"]         [-x generate xml format file]
  [-d database name]        [-K application intent]  [-l login timeout]
  */

----- The following command shows the version of the bcp:-------
bcp -v

/*

C:\Users\rohit>bcp -v
BCP - Bulk Copy Program for Microsoft SQL Server.
Copyright (C) Microsoft Corporation. All Rights Reserved.
Version: 16.0.1000.6
*/

-------------------- To view all the options of bcp, you use the following command:-------------

bcp ?

/*
C:\Users\rohit>bcp ?
usage: bcp {dbtable | query} {in | out | queryout | format} datafile
  [-m maxerrors]            [-f formatfile]          [-e errfile]
  [-F firstrow]             [-L lastrow]             [-b batchsize]
  [-n native type]          [-c character type]      [-w wide character type]
  [-N keep non-text native] [-V file format version] [-q quoted identifier]
  [-C code page specifier]  [-t field terminator]    [-r row terminator]
  [-i inputfile]            [-o outfile]             [-a packetsize]
  [-S server name]          [-U username]            [-P password]
  [-T trusted connection]   [-v version]             [-R regional enable]
  [-k keep null values]     [-E keep identity values][-G Azure Active Directory Authentication]
  [-h "load hints"]         [-x generate xml format file]
  [-d database name]        [-K application intent]  [-l login timeout]
*/

---------- Using SQL Server bcp to export data from a table to a file ---------------

------------------------ To export the data from a table to a flat file, you use the following command:--------------------

/*
bcp database_name.schema_name.table_name out "path_to_file" -c -U user_name -P password

In this syntax:

bcp is the command
database_name.schema_name.table_name is the name of the table that you want to export the data
"path_to_file" is the path to the result file.
-c option uses the character type for the format
-U user_name specifies the user that connects to the database. This user needs to have the SELECT permission on the table that you want to export.
-P password specifies the password of the user.

If you want the bcp program to connect to SQL Server with a trusted connection using integrated security,
you can use the -T option instead of specifying a username and password:

bcp database_name.schema_name.table_name out "path_to_file" -c -T

*/

/* For example, the following command exports the data of the products table 
from the production schema of the bikestores sample database into a file d:\data\products.txt :*/

/*C:\Users\rohit>bcp mastering_sql_server.production.products out "D:\bcpdata\products.txt" -c -T -S ROHIT

Starting copy...

321 rows copied.
Network packet size (bytes): 4096
Clock Time (ms.) Total     : 1      Average : (321000.00 rows per sec.)

*/

/*
It’s important to note that you need to have the data folder
on the D: drive for the command to run successfully.
*/

------------------- Using SQL Server bcp to export the result of a query to a file ------------------------

/*

To export the result set of a query to a file, you use the following command:

bcp "query" queryout "path_to_file" -w -U [username] -P [password]


Code language: plaintext (plaintext)
In this command, you specify the query inside double quotes followed by 
the bcp and use the queryout option.
*/

/*For example, the following command exports data from a query that selects 
the product name and list price from the production.products table into a file:
*/

/*Command:-
bcp "select product_name, list_price from mastering_sql_server.production.products where model_year=2017" queryout "d:\bcpdata\products001.csv" -c -t, -T -S ROHIT 
*/

/*

C:\Users\rohit>
C:\Users\rohit>bcp "select product_name, list_price from mastering_sql_server.production.products where model_year=2017" queryout "d:\bcpdata\products1.csv" -c -t, -T -S ROHIT

Starting copy...

85 rows copied.
Network packet size (bytes): 4096
Clock Time (ms.) Total     : 1      Average : (85000.00 rows per sec.)
*/


/* But it does only for random data and to do the same with columns in a csv format there are 2 approaches:-

1) Echo the columnames and append the data to it:-


echo product_name,list_price > d:\bcpdata\products001.csv

bcp "select product_name, list_price from mastering_sql_server.production.products where model_year=2017" queryout "d:\bcpdata\products001.csv" -c -t, -T -S ROHIT -a

2) Query to directly output to the csv file along with the columnames ( more reliable):-

bcp "SELECT 'product_name' as product_name, 'list_price' as list_price UNION ALL SELECT CONVERT(varchar(max), product_name), CONVERT(varchar(max), list_price) FROM mastering_sql_server.production.products WHERE model_year=2017" queryout "d:\bcpdata\products001.csv" -c -t, -T -S ROHIT

*/


/* 

Output:-
C:\Users\rohit>bcp "SELECT 'product_name' as product_name, 'list_price' as list_price UNION ALL SELECT CONVERT(varchar(max), product_name), CONVERT(varchar(max), list_price) FROM mastering_sql_server.production.products WHERE model_year=2017" queryout "d:\bcpdata\products001.csv" -c -t, -T -S ROHIT

Starting copy...

86 rows copied.
Network packet size (bytes): 4096
Clock Time (ms.) Total     : 1      Average : (86000.00 rows per sec.)

C:\Users\rohit>
*/

----------- Using SQL Server bcp to import data into a table from a file ---------------------

------ First, create a new HR database with a people table: -------

CREATE DATABASE hr;
GO

USE hr;

CREATE TABLE people (
  id int IDENTITY PRIMARY KEY,
  first_name varchar(50) NOT NULL,
  last_name varchar(50) NOT NULL
);

INSERT INTO people (first_name, last_name)
  VALUES ('John', 'Doe'), ('Jane', 'Doe');

SELECT * FROM people;

---------- Second, export the data from the people table to a file: ----------------

/* bcp hr.dbo.people OUT d:\bcpdata\people.bcp -T -c (to be executed in cmd only)*/

/*

C:\Users\rohit>bcp hr.dbo.people OUT d:\bcpdata\people.bcp -T -c

Starting copy...

2 rows copied.
Network packet size (bytes): 4096
Clock Time (ms.) Total     : 1      Average : (2000.00 rows per sec.)

*/

--------------------------- Third, truncate the people table: ---------------------------

TRUNCATE TABLE people;

----------- After that, import data from the d:\data\people.bcp into the people table:-----------

bcp hr.dbo.people IN d:\bcpdata\people.bcp -T -c

/*
C:\Users\rohit>bcp hr.dbo.people IN d:\bcpdata\people.bcp -T -c

Starting copy...

2 rows copied.
Network packet size (bytes): 4096
Clock Time (ms.) Total     : 1      Average : (2000.00 rows per sec.)

*/




---------------- Finally, verify the import by selecting data from the people table: -------------------

SELECT * FROM people;


/*
SQL Server BCP is a Bulk Copy Program that allows you to bulk-copy data between an
SQL Server instance and a data file using a specified file format.
*/

