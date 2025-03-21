------------------------------- Read Committed Snapshot Isolation ----------------------------------

/*
Read committed snapshot isolation is not a different isolation level. It is a different way of implementing
Read committed isolation level. One problem we have with Read committed isolation level is that, it blocks
the transaction if it is trying to read the data, that another transaction is updating at the same time
*/

--------------------------------- Transaction 01 --------------------------------------------------

set transaction isolation level read committed 
Begin Transaction
update tblInventory set ItemsInStock=5 where id=1 
commit transaction

select * from tblInventory

--alter database mastering_sql_server set READ_COMMITTED_SNAPSHOT OFF
 alter database mastering_sql_server set ALLOW_SNAPSHOT_ISOLATION ON

------------------------------------- Transaction 02 --------------------------------------------

--set transaction isolation level read committed
set transaction isolation level snapshot
Begin Transaction
select ItemsInStock from tblInventory where id=1 
commit transaction

select * from tblInventory

/* Now when we did implement the read committed snapshot isolation in Transaction 02 and when we update the 
value of ItemsInStock in T1 to 5 and do not commit unlike previously it did not block and retureed the
previously committed value in the ItemsinStock and hence snapshot which uses row versioning.

Remember that everytime to switch on and off the read committed snapshot isolation at the database level
we have to close other sql server sessions.

Snapshot isolation at the db level stores the snapshots in tempdb so it does not need
closing sessions and as the row versioning implementation of read_committed_snapshot_isolation
is there we need to close other sessions.

Now, lets try implementing snapshot isolation

It behaves exactly as read_committed_snapshot_isolation so whats the difference we will discuss in later
session!
*/

