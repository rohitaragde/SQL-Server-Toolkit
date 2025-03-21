--------- Difference between snapshot isolation and read committed snapshot isolation ---------------

--alter database TUT
--set ALLOW_SNAPSHOT_ISOLATION ON

--alter database TUT
--set READ_COMMITTED_SNAPSHOT OFF

----- Transaction 01

set transaction isolation level snapshot

Begin Transaction
update tblInventory
set itemsInStock=8 where id=1

commit transaction

select * from tblInventory

