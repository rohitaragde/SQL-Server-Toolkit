----------------------------- Error Handling in SQL Server ----------------------------

/* With the introduction of Try/Catch blocks in SQL Server, error handling in sql server,
is now similar to programming languages like C# and Java

Error Handling in SQL Server 2000:- @@Error
Error Handling in SQL Server 2005 & Later:- Try...Catch

Note:- Sometimes, system functions begin with two at signs(@@) are called as global
       variables. They are not variables and do not have the same behaviours as
	   variables, isntead they are very similar to functions.

RAISERROR('Error Message',ErrorSeverity,ErrorState)
Create and return custom errors
Severuty level-16(indicates general errors that can be corrected by the user)
State-Number between 1 & 255. RAISERROR only generates error with state from 1
through 127.
*/

create table tblProduct
(productid int primary key,
 product_name varchar(10),
 unitprice int,
 qtyavailable int)

 create table tblProductSales
 (productsalesid int primary key,
  productid int,
  quantitysold int,
  foreign key(productid) references tblProduct(productid))


insert into tblProduct values(1,'Laptops',2340,90)
insert into tblProduct values(2,'Desktops',3467,50)

insert into tblProductSales values(1,1,10)
insert into tblProductSales values(2,1,10) 

select * from tblProduct
select * from tblProductSales


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
		  Begin Tran
		  -- First reduce the quantity available
		  update tblProduct set qtyavailable= (qtyavailable - @QunatityToSell)
		  where productid=@Productid

		  Declare @MaxProductSalesId int
		  --- Calculate Max ProductSalesId
		  select @MaxProductSalesId= 
		  case when max(productsalesid) is null then 0 else max(productsalesid) end
		  from tblProductSales

		--- Increment @MaxProductSalesId by 1, so we dont get a primary key violation
		 set @MaxProductSalesId=@MaxProductSalesId+1
		insert into tblProductSales values(@MaxProductSalesId,@Productid,@QunatityToSell)
		If(@@ERROR<>0)
		Begin
		    rollback transaction
			print 'Transaction rolled back'
		End
		else
		   
		Begin
		   commit transaction
		   print 'Transaction committed'
		End

		End
	End



select * from tblProduct
select * from tblProductSales


----- Executing the stored proceudre for normal execution---
exec spSellProduct 1,10

/* It worked as expected qtyavailable reduced by 10 in the tblroducts table
and it updated as qtyavailable=90 and inserted a new row for prductid 1
and qtysold as 10 in the productsales table*/

---- With some error in the stored procedure ----


/* we intentionally commented this line in the stored procedure:-
  set @MaxProductSalesId=@MaxProductSalesId+1
  to introduce the error and it gives us the PK violation error.
  So it reduces the wuantity from the products table but gives us
  the PK violation error in the ProductSales table
*/

--- Error ---
/*
(1 row affected)
Msg 2627, Level 14, State 1, Procedure spSellProduct, Line 36 [Batch Start Line 88]
Violation of PRIMARY KEY constraint 'PK__tblProdu__400133659EC969C0'. Cannot insert duplicate key in object 'dbo.tblProductSales'. The duplicate key value is (1).
The statement has been terminated.

Completion time: 2024-09-08T18:11:02.6316646-04:00
*/

/*

Ideally, it should not commit the transaction before checking for errors
but in this situation even if its throwing error its still commiting the
transaction that brings the database into an inconsistent state.

"Either all the statments in a transaction should be exeucted successfully
or none of them"

*/

/* 
if there is an error it should throw the error and  rollback the transaction
and if there's no error it should commit the transaction without any error
@@ERROR system function returns non zero if there is an error and it returns
0 if there is no error.
What we are doing here is a simple modification commiting the transaction
if the @@ERROR returns 0 that means no error and rollbacking the transaction
if there is error that means @@ERROR returns non zero.
*/

/*(1 row affected)
Msg 2627, Level 14, State 1, Procedure spSellProduct, Line 37 [Batch Start Line 100]
Violation of PRIMARY KEY constraint 'PK__tblProdu__400133659EC969C0'. Cannot insert duplicate key in object 'dbo.tblProductSales'. The duplicate key value is (1).
The statement has been terminated.
Transaction rolled back

Completion time: 2024-09-08T18:24:36.8708844-04:00
*/

/* Based on the above output you can tell that as previously it updates the rows first
in the tblProduct table but once it gets the error it rollsback the transaction
and the update is beign undone and that is what we are trying to show here*/


/* Now lets uncomment the line throwing the error and we should be able to
   commit the transaction */

/*
(1 row affected)

(1 row affected)
Transaction committed

Completion time: 2024-09-08T18:28:20.7785133-04:00
*/

/* You can see from the output above it changed the qtyavailable in the tblproduct
   and inserted a new row in the tblproductsales table and committed the transaction
*/

/* 

@@ERROR returns a non-Zero value, if there is an error, otherwise zero,indicating that
the previous SQL statement encountered no errors.

Note:- @@ERROR is cleared and reset on each statement execution. Check it immediately
       following the statement being verified or save it to a local variable that can
	   be checked later

*/

insert into tblProduct values(2,'Mobile',1500,100)
if(@@ERROR<>0)
    Print 'Error Occured'
else
   Print 'No Errors'

/* The above script will throw error occured becaue of Pk violation
  and since we have executed the checking error print statement
  immediately after the execution of the
  @ERROR */


insert into tblProduct values(2,'Mobile',1500,100)
-- At this point @@ERROR will have a non-zero value ( has error)
select * from tblProduct 
--- At this point @@ERROR gets reset to ZERO,becuase the select statement 
---- successfully executed
if(@@ERROR<>0)
    Print 'Error Occured'
else
   Print 'No Errors'
/* Like here we are executing a select statement after the insert
   which is a successful execution and now post that if you check
   error even it should throw error occured it will show no error*/


Declare @Error int
insert into tblProduct values(2,'Mobile',1500,100)
set @Error=@@ERROR
select * from tblProduct
if(@Error<>0)
      Print 'Error Occured'
else
   Print 'No Errors'

/* To avoid the above scenario we stored the error into another scalar
  variable @Error and now we can get the error occured even after
  the successful select statement execution after the errorneous
  insert statement hence preserving the error state using local variable*/




select * from tblProduct
