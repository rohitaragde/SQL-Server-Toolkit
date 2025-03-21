------------------------------- Snapshot Level Isolation -----------------------------------

--- Difference between serialable and snapshot isolation level---

/*Serializable Isolation is implemented by acquiring locks which means the resources are locked
for the duration of the current transaction. This isolation level does not have any concurrecny side effects
but at the cost of significant reducation in concurrency*/

/*
Snapshot Isolation dosen't acquire locks. It maintains versioning in TempDB. Since Snapshot isolation
does not lock resources, it can significantly increase the number of concurrent transactions while
providing the same level of data consistency as serializable isolation does.
*/

--------------- Transaction 01-------------------------------------

set transaction isolation level serializable

Begin Transaction
update tblInventory
set itemsInStock=5
where id=1
\

 select * from tblInventory


