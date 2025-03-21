----------------------------------- SQL Server Bulk Insert ------------------------------------------

/*

The BULK INSERT statement allows you to import a data file into a table or view in SQL Server. 
The following shows the basic syntax of the BULK INSERT statement:

BULK INSERT table_name
FROM path_to_file
WITH options;

In this syntax:

First, specify the name of the table in the BULK INSERT clause.
Note that you can use the fully qualified table name such as database_name.schema_name.table_name.
Second, provide the path to the file in the FROM clause.
Third, use one or more options after the WITH keyword.

*/

------------------------------- SQL Server BULK INSERT statement example --------------------------

/* Let’s take an example of using the BULK INSERT statement to load data 
from a comma-separated value (CSV) file into a table. */

------------------------------  First, create a database called HR: -----------------------------

CREATE DATABASE HR;
GO

------------------ Next, create a new table Employees in the HR database: -----------------

USE HR;

CREATE TABLE Employees (
  Id int IDENTITY PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL
);

/*
The Employees table has three columns Id, FirstName, and LastName.

Then, prepare a CSV file with the path D:\data\employees.csv, which contains the following contents:

*/

/*

The employees.csv file has four rows. The first row contains the heading of the file 
and the three last rows contain the actual data. 

In practice, the data file typically contains lots of rows.

After that, load the data from the employees.csv file into the Employees table:

*/

BULK INSERT Employees
FROM 'D:\bcpdata\employees.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
);

/*
In this statement:

The table name is Employees. If you connect to the master database, you need to specify the full table name like HR.dbo.Employees
The path to the data file is D:\data\employees.csv.
The WITH clause has three options: The comma (,) as the FIELDTERMINATOR, which is a separator between columns. The newline ('\n') as the ROWTERMINATOR, which separates between rows. The first row (FIRSTROW) starts at two, not one because we won’t load the heading into the Employees table.

*/

---- Output ----

/*
(3 rows affected)
Completion time: 2024-11-02T19:43:28.3970604-04:00
*/


----------------------------- Finally, query the data from the Employees table: -----------------------

SELECT * FROM employees;

/* Use the BULK INSERT statement to import data from a file into a table. */






