-------------------- Difference between Snapshot Isolation & Read Committed Snapshot Isolation ------------------

/*

Read Committed Snapshot Isolation			    Snapshot Isolation
No update conflicts							  Vulnerable to update conflicts
Works with existing applications              Application change maybe required to use an existing application
without requiring any change
to the application 
Can be used with distributed                   Cannot be used with distributed transactions
transactions
Prevides statement-level                       provides transaction-level read consistency
read consistency

Update conflicts : Snapshot isolation is vulnerable to update conflicts where as Read Committed Snapshot 
Isolation is not. When a transaction running under snapshot isolation triess to update data that an 
another transaction is already updating at the sametime, an update conflict occurs and the transaction
terminates and rolls back with an error.

*/

------------------------------------- Transaction 01 ----------------------------------------

Set transaction isolation level snapshot
Begin Transaction
Update tblInventory set ItemsInStock = 8 where Id = 1
Commit Transaction

select * from tblInventory

------------------------------------ Transaction 02 ---------------------------------------

--Alter database mastering_sql_server SET ALLOW_SNAPSHOT_ISOLATION ON

Set transaction isolation level snapshot
Begin Transaction
Update tblInventory set ItemsInStock = 5 where Id = 1
Commit Transaction

/*
Msg 3960, Level 16, State 2, Line 7
Snapshot isolation transaction aborted due to update conflict.
You cannot use snapshot isolation to access table 'dbo.tblInventory' directly or indirectly in database 'mastering_sql_server' to update, delete, or insert the row that has been modified or deleted by another transaction. Retry the transaction or change the isolation level for the update/delete statement.

Completion time: 2025-01-09T20:47:45.9924179-05:00
*/

--------------------------------------- Implementing the same using Read Committed Snapshot Isolation ------------------------------------

------------------------------------- Transaction 01 ----------------------------------------

Set transaction isolation level read committed
Begin Transaction
Update tblInventory set ItemsInStock = 8 where Id = 1
Commit Transaction

select * from tblInventory

------------------------------------ Transaction 02 ---------------------------------------

--Alter database mastering_sql_server SET ALLOW_SNAPSHOT_ISOLATION OFF

-- Alter database mastering_sql_server SET READ_COMMITTED_SNAPSHOT ON

Set transaction isolation level read committed
Begin Transaction
Update tblInventory set ItemsInStock = 5 where Id = 1
Commit Transaction

/* In this case, Read_committed_snapshot_isolation when we ran t1 t2 was blocked as the usual behaviour but as soon as
we committed t1 t2 got executed as well and since t2 was the last one to commit we got the 
final value as 5 which is the valur of ItemsInStock that t2 updated and no update_conflict like we had in case of
snapshot_isolation.
*/

/* With read_committed_snapshot isolation we can work with exisiting applications without requiring and code changes
we just have to do Alter database mastering_sql_server SET READ_COMMITTED_SNAPSHOT ON at the db level for it to work
but with snapshot isolation we need to change everytime at the transaction level to snapshot and hence application 
required code change with snapshot isolation.
*/

/*
Read committed transaction isolation provides statement level read consistency */


------------------------------------- Transaction 01 ----------------------------------------

Set transaction isolation level read committed
Begin Transaction
Update tblInventory set ItemsInStock = 8 where Id = 1
Commit Transaction

select * from tblInventory

------------------------------------ Transaction 02 ---------------------------------------

--Alter database mastering_sql_server SET ALLOW_SNAPSHOT_ISOLATION OFF

--Alter database mastering_sql_server SET READ_COMMITTED_SNAPSHOT ON

Set transaction isolation level read committed
Begin Transaction
select * from tblInventory where Id = 1
--10

select * from tblInventory where Id = 1
--8

Commit Transaction

/* 

As we can see above in Transaction 2 we get 10 in first select thats before t1 commits so it stores the last committed value
from the database and as soon as t1 commits we get the second select as 8 in t2 that means that we get different values
for the same select at a point in time in database and hence we can see that read committed transaction isolation provides
statement level read consistenct

*/

---------------------------------------------- Lets check with Snapshot Isolation ---------------------------------------------------------



------------------------------------- Transaction 01 ----------------------------------------

Set transaction isolation level snapshot
Begin Transaction
Update tblInventory set ItemsInStock = 8 where Id = 1
Commit Transaction

select * from tblInventory

------------------------------------ Transaction 02 ---------------------------------------

--Alter database mastering_sql_server SET ALLOW_SNAPSHOT_ISOLATION ON

--Alter database mastering_sql_server SET READ_COMMITTED_SNAPSHOT OFF

Set transaction isolation level snapshot
Begin Transaction
select * from tblInventory where Id = 1
--10
--10

select * from tblInventory where Id = 1
--8
--10

Commit Transaction


select * from tblInventory where id=1

/*
Now in this case with snapshot isolation, intitial behavious was same with t1 it got updated to 8
but when we fired first select it got 10 and then we committed t1 and firesd second select in t2
we again got 10 and then we committed t2 and then we fired the same select now we got 8.

This means that t2 took the last committed value for the entire transaction which was there
before the commit took place for t1 and once t2 got committed it gave us the committed value
of t1 which is 8 and it clearly says that snapshot isolation uses transaction level read consistency
whereas with read committed transaction isolation we get statement level read consistency.
*/


