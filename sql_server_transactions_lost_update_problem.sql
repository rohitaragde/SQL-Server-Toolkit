-------------------------------- Lost Update Problem --------------------------------------------

/* Lost update problem happens when 2 or more transactions read and update the same data 

Transaction 01			Transaction 02

Read items in stock
Available: 10      

						Read items in stock. Available: 10

Sell 1 Item				


						Update items in stock:8


Update items in stock:9

*/
--update tblInventory set ItemsInStock=10 where id=1


--select * from tblInventory

------------------------------ Transaction 01 --------------------------------------
--- set transaction isolation level repeatable read


Begin Transaction
Declare @ItemsInStock int

select @ItemsInStock=ItemsInStock 
from tblInventory where id=1

Waitfor Delay '00:00:10'
set @ItemsInStock=@ItemsInStock-1

update tblInventory
set ItemsInStock=@ItemsInStock where id=1

Print @ItemsInStock
Commit Transaction

------------------------------------- Transaction 02 ------------------------------------------------
--- set transaction isolation level repeatable read
--select * from tblInventory 

Begin Transaction
Declare @ItemsInStock int

select @ItemsInStock=ItemsInStock 
from tblInventory where id=1

Waitfor Delay '00:00:1'
set @ItemsInStock=@ItemsInStock-2

update tblInventory
set ItemsInStock=@ItemsInStock where id=1

Print @ItemsInStock
Commit Transaction


/*

Here, Transaction 2 completes before with an value in ItemsInStock as 8 and then transaction 1
completes with the ItemsInStock value as 9. However, Transaction 1 should have had a value of 7
but since transaction 1 silently overwritten the value of transaction 2 it has a value of 9
as it considers 10 as the original value.

The default isolation level of SQL Server is read committed. Lost update problem occurs only with
read committed and read uncommitted isolation levels.
*/

/*

Now when we set the transaction isolation level as repeatable read, as the transaction 1 already
reads the data and transaction 2 reads and tries to update the value it gets blocked with the
below message:-

Msg 1205, Level 13, State 51, Line 14
Transaction (Process ID 88) was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction.

Completion time: 2025-01-07T18:32:23.9201655-05:00

Repeatable read makes sure that no other transaction can read or modify the data that transaction 1
has read. Transaction 2 is being made as deadlock victim because it was waiting for the transaction 1
to complete!

When we rerun the transaction 2 as mentioned in the message above:-

(1 row affected)
7

Completion time: 2025-01-07T18:38:13.9204693-05:00

We got 7 as expected which should be the value after all the transactions complet successfully!

*/ 









