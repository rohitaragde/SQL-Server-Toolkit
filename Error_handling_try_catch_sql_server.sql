------------------- Error Handling using Try... Catch -----------------------


alter procedure spSellProduct 
@Productid int,
@QunatityToSell int
as 
Begin
       -- Check the stock available for the product we want to sell
	   Declare @StockAvailable int
	   select @StockAvailable=QtyAvailable 
	   from tblProduct where productid=@Productid

	   -- Throw an error to the calling Application, if enough stock
	   -- is not available

	   if(@StockAvailable <@QunatityToSell)
	      Begin
		    Raiserror('Not enough stock available',16,1)
		  End

		---- If enough stock available ----

		Else
		  Begin
		  begin Try
		  Begin Transaction
		  -- First reduce the quantity available
		  update tblProduct set qtyavailable= (qtyavailable - @QunatityToSell)
		  where productid=@Productid

		  Declare @MaxProductSalesId int
		  --- Calculate Max ProductSalesId
		  select @MaxProductSalesId= 
		  case when max(productsalesid) is null then 0 else max(productsalesid) end
		  from tblProductSales

		--- Increment @MaxProductSalesId by 1, so we dont get a primary key violation
		--- set @MaxProductSalesId=@MaxProductSalesId+1
		insert into tblProductSales values(@MaxProductSalesId,@Productid,@QunatityToSell)
		commit transaction
		End Try
		Begin Catch
		  Rollback Transaction
		  select 
		     ERROR_NUMBER() as ErrorNumber,
			 ERROR_MESSAGE() as ErrorMessage,
			 ERROR_PROCEDURE() as ErrorProcedure,
			 ERROR_STATE() as ErrorState,
			 ERROR_SEVERITY() as ErrorSeverity,
			 ERROR_LINE() as ErrorLine
		End Catch
		End
	End

/* In this approach we are utilizing the same stored procedure but
   we are utilizing try-catch block for the errors instead of @@ERROR()
   system function.

   Now, Initially we wrapped the entire block from checking for quantity
   available to inserting into a try block and ended it with a commit transaction
   statement. Similarly, attached a catch block and introduced system
   functions for varrious error functions like errornumber, message,
   procedure causing the error,errorstae,severity and errorline in the
   catch block and ended it with a rollback transaction so if the transaction
   fails it should print the error and rollback the transaction.


   Intially we executed without commenting the increment line which introduces
   the PK violation error and then later on we commented the line to intrduce the
   error and then we could see the catch block error functions values.

   Note:- if used the error functions outside the context of the catch block
          they will print NULL. Only if there is an error and we use the error
		  functions within the context of the catch block it will print the
		  appropriate values.

Also, Errors trapped by the catch block are not returned by the calling
application. In order to do so we can use Raiserror() function.

*/


--- To check the data ----
	select * from tblProduct 
	select * from tblProductSales 

--- procedure Execution ----
	exec spSellProduct 2,5
