-------------------------------- Non-repeatable Read --------------------------------------

/*

                       Non-Repeatable Read Concurrency Problem 


Non-Repeatable Read happens when one transaction reads the same data twice and another transaction
updates that data in between the first and second read of transaction one

Transaction 01				 Transaction 02

Read 1: ItemsInStock=10		   


Doing some work					Update: ItemsInStock=5


Read 2: ItemsInStock=5
update tblInventory set ItemsInStock=10 where id=1
*/

------------------------------------ Transaction 01 --------------------------------------------
--set transaction isolation level repeatable read
--select * from tblInventory


Begin Transaction
select ItemsInStock from tblInventory where id=1

waitfor delay '00:00:10'

select ItemsInStock from tblInventory where id=1

commit Transaction

--------------------------------- Transaction 02 -----------------------------------------

update tblInventory set ItemsInStock=5 where id=1 

select * from tblInventory



/*

As you can see after both the transaction completed we got different values
for ItemsInStock first as 10 followed by 5 and hence the name non-repeatable read!

ItemsInStock
10

ItemsInStock
5

*/
/* to solve this problem we set the transaction isolation level to repeatable read for transaction 01
so that it places lock and not allow transaction 2 to update data after transaction 1 
completes first read and when it reads again so it will read the same value  both the times
*/

/*

ItemsInStock
10

ItemsInStock
10

So as per the above output since we had set the transaction isolation level to repeatable read
transaction 2 was blocked and it was able to update the ItemsInStock value to 5 only after
transaction 1 completed and in transaction 1 both reads produces 10 and hence it solves the 
problem of non-repeatable read concurrency

*/








