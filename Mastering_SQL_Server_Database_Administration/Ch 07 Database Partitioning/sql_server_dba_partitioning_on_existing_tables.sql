----------------------------- Partitioning on Existing Tables ----------------------------

/*

The steps for partitioning an existing table are as follows:

Create filegroups
Create a partition function
Create a partition scheme
Create a clustered index on the table based on the partition scheme.
We’ll partition the sales.orders table in the BikeStores database by years.

*/

---------------------------------- Create Filegroups -------------------------------------

/*First, create two new file groups will store the rows with the order dates in 2016 and 2017:
*/

ALTER DATABASE mastering_sql_server
ADD FILEGROUP salesorders_2016;

ALTER DATABASE mastering_sql_server
ADD FILEGROUP salesorders_2017;

/* Second, map the filegroups with the physical files. Note that you need to have 
the C:\data folder in the server before executing the following statements:*/

ALTER DATABASE mastering_sql_server    
ADD FILE     (
    NAME = salesorders_2016,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\salesorders_2016.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP salesorders_2016;

ALTER DATABASE mastering_sql_server    
ADD FILE     (
    NAME = salesorders_2017,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\salesorders_2017.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP salesorders_2017;

--------------------------------- Create a partition function ---------------------------------

/* Create a partition function that accepts a date and returns three partitions: */

CREATE PARTITION FUNCTION sales_order_by_year_function(date)
AS RANGE LEFT 
FOR VALUES ('2016-12-31', '2017-12-31');

------------------------------ Create a partition scheme -------------------------------------

/* Create a partition scheme based on the sales_order_by_year_function partition function:*/

CREATE PARTITION SCHEME sales_order_by_year_scheme
AS PARTITION sales_order_by_year_function
TO ([salesorders_2016], [salesorders_2017], [primary]);

------------------------ Create a clustered index on the partitioning column --------------------------

/*
The orders table has the order_id as the primary key. This primary key column is also included 
in a clustered index.

To partition the orders table by the order_date column, you need to create a clustered index 
for the order_date column on the partition scheme sales_order_by_year_scheme.

To do that, you need to change the clustered index that includes the order_id column 
to a non-clustered index so that you can create a new clustered index that includes 
the order_date column.

But the order_id is referenced by a foreign key in the order_items table. 
Therefore, you need to perform these steps:
*/

------------------------- First, remove the foreign key order_id from the order_items table:----------------------

ALTER TABLE [sales].[order_items] 
DROP CONSTRAINT [FK__order_ite__order__5FB337D6]

----------------------  Second, remove the primary key constraint from the orders table: -----------------------

ALTER TABLE [sales].[orders] 
DROP CONSTRAINT [PK__orders__46596229890B23BB];

--------------- Third, add the order_id as a non-clustered primary key on the PRIMARY partition:-----------

ALTER TABLE [sales].[orders] 
ADD PRIMARY KEY NONCLUSTERED([order_id] ASC) 
ON [PRIMARY];

/* Fourth, create a clustered index that includes the order_date column: */

CREATE CLUSTERED INDEX ix_order_date 
ON [sales].[orders]
(
	[order_date]
) ON [sales_order_by_year_scheme]([order_date])


/*Finally, add the foreign key constraint back to the order_items table:*/

ALTER TABLE [sales].[order_items]  
WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [sales].[orders] ([order_id])
ON UPDATE CASCADE
ON DELETE CASCADE;

/* It’s better to run all the statements above in a transaction like this:*/

BEGIN TRANSACTION;

ALTER TABLE [sales].[order_items] 
DROP CONSTRAINT [FK__order_ite__order__3A81B327];

ALTER TABLE [sales].[orders] 
DROP CONSTRAINT [PK__orders__46596229EDE70106];


ALTER TABLE [sales].[orders] ADD PRIMARY KEY NONCLUSTERED 
(
	[order_id] ASC
) ON [PRIMARY];

CREATE CLUSTERED INDEX ix_order_date 
 ON [sales].[orders]
(
	[order_date]
) ON [sales_order_by_year_scheme]([order_date]);



ALTER TABLE [sales].[order_items]  
WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [sales].[orders] ([order_id])
ON UPDATE CASCADE
ON DELETE CASCADE;

COMMIT TRANSACTION;


/* To check the number of rows in each partition, you use the following query: */

SELECT 
	p.partition_number AS partition_number,
	f.name AS file_group, 
	p.rows AS row_count
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'orders'
order by partition_number;



