

-------------------------- Transaction 02 -------------------------------------

Alter database master
set ALLOW_SNAPSHOT_ISOLATION ON

set transaction isolation level snapshot

Begin Transaction

select itemsInStock from tblInventory where id=1

Commit Transaction

select * from tblInventory