--------------------- Transaction 02 ----------------------------

--alter database TUT
--SET ALLOW_SNAPSHOT_ISOLATION ON


set transaction isolation level snapshot

Begin Transaction
select itemsInStock from tblInventory where id=1
commit Transaction


--select * from tblInventory;



