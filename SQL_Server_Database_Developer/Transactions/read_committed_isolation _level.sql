-------------- Read Committed Snapshot Isolation level in SQL Server ------------------------

------- Transaction 01 -------------

set transaction isolation level read committed
Begin Transaction
update tblInventory
set itemsInStock=5 where id=1

commit transaction

select * from tblInventory