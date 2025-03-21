------------------------------------- Lost Update ----------------------------------------------------

---- Transaction 01

set transaction isolation level repeatable read

 select * from tblInventory;

 Begin Transaction
 Declare @ItemsInStock int

 select @itemsInStock=itemsInStock
 from tblInventory
 where id=1

 waitfor Delay '00:00:10'

 set @ItemsInStock=@ItemsInStock-1

 update tblInventory
 set itemsInStock=@ItemsInStock where id=1

 Print @ItemsInStock
 Commit Transaction








