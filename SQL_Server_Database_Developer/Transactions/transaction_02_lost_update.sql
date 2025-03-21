------ Transaction 02 ------------------

set transaction isolation level repeatable read

Begin Transaction
 Declare @ItemsInStock int

 select @itemsInStock=itemsInStock
 from tblInventory
 where id=1

 waitfor Delay '00:00:1'

 set @ItemsInStock=@ItemsInStock-2

 update tblInventory
 set itemsInStock=@ItemsInStock where id=1

 Print @ItemsInStock
 Commit Transaction
