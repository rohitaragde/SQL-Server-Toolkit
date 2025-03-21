-- Create a sample Employee table
CREATE TABLE Employee9 (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Salary DECIMAL(10, 2)
);

BEGIN TRY
    -- Attempt to insert a record into the Employee table
    INSERT INTO Employee9 (EmployeeID, Name, Salary)
    VALUES (1, 'John Doe', 50000.00);
    
    -- Force an error by trying to insert a duplicate EmployeeID
    INSERT INTO Employee9 (EmployeeID, Name, Salary)
    VALUES (1, 'Jane Smith', 60000.00);
END TRY
BEGIN CATCH
    -- Handle the error
    DECLARE @ErrorNumber INT = ERROR_NUMBER();
    PRINT 'An error occurred. Error Number: ' + CAST(@ErrorNumber AS NVARCHAR(10));
    -- You can add additional error handling logic here
END CATCH;

