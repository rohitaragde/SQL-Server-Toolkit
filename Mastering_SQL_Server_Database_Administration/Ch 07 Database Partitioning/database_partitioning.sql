
------------------------------------- Database Partitioning -----------------------------------------

-- query returns the order amount by dates and products:

WITH order_data (order_date, product_name, amount)
AS (
SELECT
  order_date,
  product_name,
  SUM(i.quantity * i.list_price * (1 - discount))
FROM sales.orders o
INNER JOIN sales.order_items i
  ON i.order_id = o.order_id
INNER JOIN production.products p
  ON p.product_id = i.product_id
GROUP BY order_date,
         product_name
)

SELECT * FROM order_data;

-- query returns the summary of the orders:

WITH order_data (order_date, product_name, amount)
AS (SELECT
  order_date,
  product_name,
  SUM(i.quantity * i.list_price * (1 - discount))
FROM sales.orders o
INNER JOIN sales.order_items i
  ON i.order_id = o.order_id
INNER JOIN production.products p
  ON p.product_id = i.product_id
GROUP BY order_date,
         product_name)

SELECT
  YEAR(order_date) year,
  COUNT(*) row_count
FROM order_data
GROUP BY YEAR(order_date);

/*
We’ll create a partitioned table called sales.order_reports that stores the order data 
returned by the above query. The sales.order_reports table will have three partitions.
And each partition will store rows whose order dates will be in 2016, 2017, and 2018.
*/

-------------------------- Creating File Groups ------------------------------------
/*

When creating a database, SQL Server creates at least two files: a data file and a log file:

The data file contains data and objects like tables, indexes, and views.
The log file contains the information for recovering the transactions in the database.
SQL Server allows you to store the data in multiple data files and uses the filegroup to
group data files. By default, the data file belongs to the PRIMARY filegroup.
To add more filegroups to a database, you use the ALTER DATABASE ... ADD FILEGROUP statement.
*/

--First, add three filegroups to the BikeStores (mastering_sql_server in my case) database:

ALTER DATABASE mastering_sql_server
ADD FILEGROUP orders_2016;

ALTER DATABASE mastering_sql_server
ADD FILEGROUP orders_2017;

ALTER DATABASE mastering_sql_server
ADD FILEGROUP orders_2018;

-- Second, verify the filegroups of the current database by using the following statement:

SELECT
  name
FROM sys.filegroups
WHERE type = 'FG';

-- Third, assign physical files to the filegroups:

ALTER DATABASE mastering_sql_server    
ADD FILE     (
    NAME = orders_2016,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\orders_2016.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP orders_2016;

ALTER DATABASE mastering_sql_server    
ADD FILE     (
    NAME = orders_2017,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\orders_2017.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP orders_2017;

ALTER DATABASE mastering_sql_server    
ADD FILE     (
    NAME = orders_2018,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\orders_2018.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP orders_2018;


/*In this example, we assign three files located in the C:\data to the filegroups.

Finally, verify the filegroup assignment using the following statement:
*/

SELECT 
	name as filename,
	physical_name as file_path
FROM sys.database_files
where type_desc = 'ROWS';

----------------------- Now, Create a Partition Function -------------------------------

/*
A partition function is a database object that maps the rows of a table to partitions based
on the values of a specified column. That column is called a partitioning column.
A partition function takes values of the partitioning column and returns a partition value. 
Also, it defines the number of partitions and partition boundaries.
In our example, the partitions will be based on the values of the order_date column. 
And the partition function will create three partitions:
*/

-- DROP PARTITION FUNCTION order_by_year_function;

CREATE PARTITION FUNCTION order_by_year_function (date)
AS RANGE LEFT 
FOR VALUES ('2016-12-31', '2017-12-31');

/*

In this statement:-

The order_by_year_function is the name of the partition function.
It takes an argument whose data type is DATE.
The AS RANGE LEFT FOR VALUES specifies three boundaries in which the rows with the date
before 2016-12-31 will belong to the partition 1, 
the rows with the date before 2017-12-31 and after 2016-12-31 will belong to the partition 2,
the rows with the date between 2017-12-31 and 2018-12-31 will belong to the partition 3.

*/

------------------------ Creating a Partition Scheme ---------------------------------

/*

A partition scheme is a database object that maps the partitions returned by a partition function
to filegroups.The following statement creates a partition scheme that maps the partitions
returned by order_by_year_function to filegroups:
*/

-- DROP PARTITION SCHEME order_by_year_scheme;

CREATE PARTITION SCHEME order_by_year_scheme
AS PARTITION order_by_year_function
TO ([orders_2016], [orders_2017], [orders_2018]);

------------------------------- Create Partitioned Table ---------------------------------------

-- The following statement creates a partitioned table based on the order_by_year_scheme partition scheme:

CREATE TABLE sales.order_reports (
  order_date date,
  product_name varchar(255),
  amount decimal(10, 2) NOT NULL DEFAULT 0,
  PRIMARY KEY (order_date, product_name)
) 
ON order_by_year_scheme (order_date);


/*
The ON order_by_year_scheme (order_date) clause specifies the partition scheme and
partition column (order_date) for the table.
The partition column must be included in a clustered index or you’ll get an error.
*/

----------------- Insert Scipt for Partitioned Table ---------------------

INSERT INTO sales.order_reports (order_date, product_name, amount)
  SELECT
    order_date,
    product_name,
    SUM(i.quantity * i.list_price * (1 - discount))
  FROM sales.orders o
  INNER JOIN sales.order_items i
    ON i.order_id = o.order_id
  INNER JOIN production.products p
    ON p.product_id = i.product_id
  GROUP BY order_date,
           product_name;

/*

(4437 rows affected)

Completion time: 2024-10-26T19:23:46.6701703-04:00
*/

-------------------------------- Check the rows of each partition --------------------------------

SELECT 
	p.partition_number AS partition_number,
	f.name AS file_group, 
	p.rows AS row_count
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'order_reports'
order by partition_number;

------------------------------------ Queries -----------------------------------------

DBCC DROPCLEANBUFFERS;
DBCC FREEPROCCACHE;

-- First query (using base tables - original way)
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT
    order_date,
    product_name,
    SUM(i.quantity * i.list_price * (1 - discount)) as amount
FROM sales.orders o
INNER JOIN sales.order_items i
    ON i.order_id = o.order_id
INNER JOIN production.products p
    ON p.product_id = i.product_id
WHERE order_date >= '2017-01-01' 
    AND order_date < '2018-01-01'
GROUP BY order_date,
         product_name;

-- Second query (using partitioned table)
SELECT 
    order_date,
    product_name,
    amount
FROM sales.order_reports
WHERE order_date >= '2017-01-01' 
    AND order_date < '2018-01-01';

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;



