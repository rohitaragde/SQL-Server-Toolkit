-- Step 1: Enable advanced options and configure Ad Hoc Distributed Queries
-- This allows SQL Server to execute distributed queries such as OPENROWSET.

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;

-- Step 2: Insert data from the Excel file into the Employees table
-- Specify the exact path to your Excel file and the sheet name in the query.
-- Ensure that your Excel file has the columns in the same order as your table.

INSERT INTO HR.dbo.Employees (Id, FirstName, LastName)
SELECT * FROM OPENROWSET(
    'Microsoft.ACE.OLEDB.12.0',
    'Excel 12.0;HDR=YES;Database=D:\bcpdata\employees.xlsx',
    'SELECT * FROM [employees$]'
);

-- Verify the data has been inserted into the Employees table.
SELECT * FROM HR.dbo.Employees;

-- Step 3: Temporarily enable IDENTITY_INSERT for the Employees table
-- This allows explicit values to be inserted into the identity column (Id).
SET IDENTITY_INSERT HR.dbo.Employees ON;

-- Step 4: Insert data again, specifying Id, FirstName, and LastName
-- Make sure the Excel file includes an Id column with unique values.
INSERT INTO HR.dbo.Employees (Id, FirstName, LastName)
SELECT * FROM OPENROWSET(
    'Microsoft.ACE.OLEDB.12.0', 
    'Excel 12.0;HDR=YES;Database=D:\bcpdata\employees.xlsx', 
    'SELECT * FROM [employees$]'
);

-- Step 5: Disable IDENTITY_INSERT after the insert is complete
-- This prevents any further explicit inserts to the identity column.
SET IDENTITY_INSERT HR.dbo.Employees OFF;

-- Step 6: Query the data from the Employees table to verify the inserts
SELECT * FROM HR.dbo.Employees;

-------------------------------------------------- to move data from SQL to Excel ---------------------------------------------------
------------------------------------------------    (in cmd using bcp utility) -------------------------------------------------------
bcp "SELECT 'product_name' as product_name, 'list_price' as list_price UNION ALL SELECT CONVERT(varchar(max), product_name), CONVERT(varchar(max), list_price) FROM mastering_sql_server.production.products WHERE model_year=2017" queryout "d:\bcpdata\products001.xlsx" -c -t, -T -S ROHIT

bcp "SELECT 'product_name' as product_name, 'list_price' as list_price UNION ALL SELECT CONVERT(varchar(max), product_name), CONVERT(varchar(max), list_price) FROM mastering_sql_server.production.products WHERE model_year=2017" queryout "d:\bcpdata\products50.xlsx" -c -t, -T -S ROHIT
