------------------------------ Snapshot Isolation Level ---------------------------------

/*

Just like serializable isolation level, snapshot isolation level also does not have any concurrency
side effects.

Difference between Serializable and Snapshot Isolation levels

Serializable Isolation is implemented by acquiring locks which means the resources are locked for 
the duration of the current transaction. This isolation level does not have any concurrency
side effects but at the cost of significant reduction in concurrency.

Snapshot Isolation dosent acquire locks. It maintains versioning in Tempdb. Since, Snapshot Isolation
does not lock resources, it can significantly increase the number of concurrent transactions while
providing the same level of data consistency as serializable isolation does.

*/


------------------------------------ Transaction 01 -----------------------------------------

set transaction isolation level serializable

Begin Transaction
update tblInventory set ItemsInStock=5 where id=1 

commit transaction

-- select * from tblInventory

/*

When we used serializable transaction isolation level and intially did not commit and simultaneously
executed transaction 02 the transaction 02 is blocked as it was accessing the resources acquired
by t1 and as its serializable t2 was locked and as soon as we committed t1 t2 got executed and then
we committed t2 as well and this is how serializable transaction isolation works.

*/

/* for snapshot isolation we have to set the snapshot isolation on database level in t2
( does not matter as its on database level)


*/

we set the database level snapshot isolation and transaction isolation level in t2
and then kept the t1 same and executed simultaneously and once t1 was executed and
when we checked t2 it had a value of 10 which was the initial value of the stocks 
and post update by t1 it should have been 5 but since t1 did not commit and t2 reads
snapshot which is taken before t1 starts it works well so snapshot does not acquire locks
instead keeps snapshots in tempDB and hence increases concurrency!

*/

----------------------------- Modifying Data with Snapshot Isolation ---------------------------

set transaction isolation level serializable

Begin Transaction
update tblInventory set ItemsInStock=5 where id=1 

commit transaction

-- select * from tblInventory

-------------------------------- Transaction 02 --------------------------------

--alter database mastering_sql_server set allow_snapshot_isolation ON
--set transaction isolation level snapshot

--set transaction isolation level serializable

Begin Transaction

update  tblInventory 
set ItemsInStock=8
where id=1 

commit transaction

select * from tblInventory


/*

When performing update among 2 transactions with snapshot isolation, it fails becuase
you cannot update the same data which is updated by one transaction and another one
tries to update the same value it wont work.

Basically we updated it in t1 and then didnt commit and in t2 with snapshot isolation
tried to update it as it retains snapshots but we got the below error:-

Msg 3960, Level 16, State 2, Line 10
Snapshot isolation transaction aborted due to update conflict. 
You cannot use snapshot isolation to access table 'dbo.tblInventory' 
directly or indirectly in database 'mastering_sql_server' to update, delete, or insert 
the row that has been modified or deleted by another transaction. 
Retry the transaction or change the isolation level for the update/delete statement.

Completion time: 2025-01-07T20:46:34.5400110-05:00

*/

/* if you allow it to update it will overwrite the value which again is a lost update 
  problem and for the same reason its blocked and serves the purpose and so when
  you rerun it it works successfully and hence you cant update 2 transactions
  simultaneously using snapshot isolation.
*/