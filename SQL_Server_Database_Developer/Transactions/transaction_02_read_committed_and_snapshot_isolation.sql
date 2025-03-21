------------------------- Transaction 02 ----------------------------

set transaction isolation level snapshot

Begin Transaction

select * from tblInventory where id=1
--10
--10
select * from tblInventory where id=1
--8
--10
commit Transaction

select * from tblInventory where id=1;

/*Snapshot isolation gives us transaction level read consistency
the above 2 select statements are part of the same transaction
so whatever was the committed value in the database before this
transaction began thats what  you will get throughout that transaction

whereas with read committed snapshot isolation we get statement level
read consistency.
*/