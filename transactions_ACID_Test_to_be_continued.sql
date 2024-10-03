--------------------- Transaction ACID Test -----------------------------------

/*

A transaction is a group of database commands that are treated as a single
unit. A successful transaction must pass the "ACID" test i.e. it must be:-

a) Atomic:- All statements in the transaction either completed successfully
            or they were all rolledback. The task that the set of operations
			represents is either accomplished or not, but in any case not 
			left half done.

b) Consistent:- All data touched by the transaction is left in a logically
                consistent state. For example, if stock available numbers are
				decremented from tblProductTable then there has to be a related
				entry in tblProductSales table. The inventory cant just disappear.
*/


select * from tblProduct
select * from tblProductSales


select * from tblProductSales;

exec spUpdateInventory_and_Sell

alter PROCEDURE spUpdateInventory_and_Sell
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE tblProduct
        SET QntyAvailable = (QntyAvailable - 10)
        WHERE ProductId = 1;

        INSERT INTO tblProductSales (ProductSalesId, ProductID, QuantitySold)
        VALUES (4, 3, 10);

        COMMIT TRANSACTION;
        PRINT 'Transaction Committed';
    END TRY
    BEGIN CATCH
            ROLLBACK TRANSACTION;
        PRINT 'Transaction RolledBack';
    END CATCH;
END;


select * from tblProduct


select * from tblProductSales 
