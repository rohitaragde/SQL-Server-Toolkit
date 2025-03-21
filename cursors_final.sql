---------------------- Cursors in SQL Server--------------------------

/*
Relational Database Management Systems including SQL Server are very good at
handling data in SETS. For example, the following "UPDATE" query, updates a
set of rows that matches the condition in the "WHERE" clause at the same time.

update tblProductSales set unitprice=50 where productid=101

However, if there is a need to process the rows, on a row-by-row basis, then
cursors are your choice. Cursors are very bad for performance and should be
avoided always. Most of the time, cursors can be very easily replaced using joins.

*/


select * from tblProducts
select * from tblProductSales

/*

There are various kinds of cursors in SQL Server:-
a) Forward Only
b) Static
c) keyset
d) Dynamic

The cursor will loop through each row in tblproductSales table. As there are
600,000 rows tobe processed on a row by row basis,it takes around 40-45 seconds
on my machine. We can achieve this very easily using a join, and this will
significantly improve the performance.

*/

---------------  Basic Cursor Execution Script ----------------------

declare @productid int
declare @name nvarchar(30)

declare ProductCursor CURSOR FOR
select id,name from tblProducts where id<=1000

open ProductCursor

fetch next from ProductCursor into @productid,@name

while(@@FETCH_STATUS=0)
Begin
     print 'Id= ' + cast(@productid as nvarchar(10)) + 'Name= ' + @name
      Fetch next from ProductCursor into @productid,@name
End

Close ProductCursor
DEALLOCATE ProductCursor 

----------------------------- Cursor script that incolvles both the tables updates --------------

Declare @ProductId int

-- Declare the cursor using the declare keyword
Declare ProductIdCursor CURSOR FOR 
Select ProductId from tblProductSales

-- Open statement, executes the SELECT statment
-- and populates the result set
Open ProductIdCursor

-- Fetch the row from the result set into the variable
Fetch Next from ProductIdCursor into @ProductId

-- If the result set still has rows, @@FETCH_STATUS will be ZERO
While(@@FETCH_STATUS = 0)
Begin
 Declare @ProductName nvarchar(50)
 Select @ProductName = Name from tblProducts where Id = @ProductId
 
 if(@ProductName = 'Product - 55')
 Begin
  Update tblProductSales set UnitPrice = 55 where ProductId = @ProductId
 End
 else if(@ProductName = 'Product - 65')
 Begin
  Update tblProductSales set UnitPrice = 65 where ProductId = @ProductId
 End
 else if(@ProductName like 'Product - 100%')
 Begin
  Update tblProductSales set UnitPrice = 1000 where ProductId = @ProductId
 End
 
 Fetch Next from ProductIdCursor into @ProductId 
End

-- Release the row set
CLOSE ProductIdCursor 
-- Deallocate, the resources associated with the cursor
DEALLOCATE ProductIdCursor
------------------------ Select query to check the output ---------------------

Select  Name, UnitPrice 
from tblProducts join
tblProductSales on tblProducts.Id = tblProductSales.ProductId
where (Name='Product - 55' or Name='Product - 65') or Name like 'Product - 100%')

