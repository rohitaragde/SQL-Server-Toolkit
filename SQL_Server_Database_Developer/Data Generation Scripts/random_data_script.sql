-- First, clear the existing table if needed
TRUNCATE TABLE emp19;

-- Declare variables for loop
DECLARE @Counter INT = 1
DECLARE @TargetCount INT = 1575  -- This should generate ~5 logical reads (315 records/page * 5 pages)
DECLARE @RandomName VARCHAR(20)
DECLARE @FirstNames TABLE (Name VARCHAR(20))
DECLARE @LastNames TABLE (Name VARCHAR(20))

-- Insert sample first names
INSERT INTO @FirstNames VALUES 
('John'),('Jane'),('Michael'),('Sarah'),('David')

-- Insert sample last names
INSERT INTO @LastNames VALUES 
('Smith'),('Johnson'),('Brown'),('Davis'),('Wilson')

-- Begin transaction for better performance
BEGIN TRANSACTION

WHILE @Counter <= @TargetCount
BEGIN
    -- Generate random name by combining random first and last name
    SELECT @RandomName = 
        (SELECT TOP 1 Name FROM @FirstNames ORDER BY NEWID()) + ' ' +
        (SELECT TOP 1 Name FROM @LastNames ORDER BY NEWID())

    -- Insert the record
    INSERT INTO emp19 (empnumber, empname)
    VALUES (@Counter, @RandomName)

    SET @Counter = @Counter + 1
END

-- Commit the transaction
COMMIT TRANSACTION

-- Verify the count and check logical reads
SET STATISTICS IO ON;
SELECT COUNT(*) FROM emp19;