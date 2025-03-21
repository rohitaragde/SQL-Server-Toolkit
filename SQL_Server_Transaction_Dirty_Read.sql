----------------------------- SQL Server Dirty Read ----------------------------------

/*
A Dirty Read happens when one transaction is permitted to read data that has been modified by
another transaction that has not yet been committed. In most cases this would not cause a
problem. However if the first transaction is rolledback after the second reads the data
the second transaction has dirty data that does not exist anymore.

Transaction 1				Transaction 2
Updates ItemsInStock:9		

Billing Customer							Reads ItemsInStock:9


Insufficient Funds
Transaction rolledback
Reverts ItemsInStock:10


*/

create table tblInventory
(
  id int primary key,
  products varchar(10),
  ItemsInStock int
)

insert into tblInventory values(1,'iPhone',10);

select * from tblInventory

----------------------------- Transaction 1 --------------------------------------
select * from tblInventory

Begin Transaction
update tblInventory set ItemsInStock=9
where id=1 

---- Bill the Customer ----

Waitfor Delay '00:00:15'
Rollback Transaction

--------------------------- In another sql server window -------------------------------

---------------------------------- Transaction 2 -----------------------------------------

select * from tblInventory

select * from tblInventory
where id=1 


/* when you do this since the default isolation level of SQL Server is read committed the 
transaction 2 will be blocked until transaction 1 is completed and hence both the 
transactions will be reading the final updated value as transaction 2 reads data only
when transaction 1 completes */

/* to perform dirty read we have to set the transaction isolation level to read uncommitted'*/

/* now since we have set the transaction isolation level to read uncommitted we were able to
read uncommitted data and as a result the transaction 2 was not blocked and the read the
ItemsInStocks value as 9 while the transaction 1 was still getting executed and once done
it was updated it had a value of 10 and hence dirty read */

/*
Transaction 01 output
id	products	ItemsInStock
1	iPhone	10

Transaction 02 output
id	products	ItemsInStock
1	iPhone	9
*/

/*
Read uncommitted transaction isolation is the only isolation level that has dirty read side
effect. This is the least restrictive of all isolation levels. When this transaction isolation
level is set, it is possible to read uncommitted or dirty data. Another option to read dirty
data is by using NOLOCK table hint. 
*/

------------------------------ Another way of Reading Dirty Data ------------------------

/* For instance you ran just the update in transaction 01 without either commit or rollback
and then in transaction 2 since its read committed it wont allow you to read and block
the transaction.

There is another way to read uncommitted data without setting isolation level to
read uncommitted using NOLOCK table hint option in the transaction 02:-
*/

select * from tblInventory (NOLOCK)
where id=1 
