------------------------------------ Transaction 02 ----------------------------------------------

---------------------- Enable snapshot isolation for the database -----------------------------

alter database master
set ALLOW_SNAPSHOT_ISOLATION ON

------------ Set the transaction isolation level to snapshot ------------------------------------

set transaction isolation level snapshot

update tblInventory
set itemsInStock=8
where id=1

select * from tblInventory

/*
Msg 3960, Level 16, State 2, Line 12
Snapshot isolation transaction aborted due to update conflict.
You cannot use snapshot isolation to access table 'dbo.tblInventory' directly or
indirectly in database 'master' to update, delete, or insert the row that has been modified
or deleted by another transaction. Retry the transaction or change the isolation level for the 
update/delete statement.

Completion time: 2024-07-08T21:25:19.3151839-04:00
*/

