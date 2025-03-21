----------------------- Modifying Data with Snapshot Isolation -----------------------------------

--------------- Transaction 01 -------------------------

set transaction isolation level serializable
Begin Transaction
update tblInventory set itemsInStock=5 where id=1
waitfor delay  '00:00:10'


commit transaction

select * from tblInventory

