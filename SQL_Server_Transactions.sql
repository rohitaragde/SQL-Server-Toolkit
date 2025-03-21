------------------------------------ SQL Server Transactions -------------------------------------

/*
A transaction is a group of commands that change the data stored in a database. A transaction is
treated as a single unit of work

A transaction ensures that either all of the commands within a transaction are executed successfully
or none of them. If any command in the transaction fails all of them fails and if any data that was
modified within the database is rolledback elseway transactions maintain the integrity of the data
in the database!

*/


create table Accounts
(
 id int primary key,
 AccountName varchar(20),
 balance int
 )

 insert into Accounts values(1,'Mark',1000)
 insert into Accounts values(2,'Mary',1000)

 select * from Accounts

 --- Transfer $100 from Mark to Mary Account ---

 Begin Try
 Begin Transaction
 update Accounts set balance=balance-100 where id=1
 update Accounts set balance=balance+100 where id='A' 
 commit Transaction
 print 'Transaction Committed'
 End Try
 Begin Catch
 Rollback Transaction
 print 'Transaction Rolled back'
 End Catch

 /*(1 row affected)

(1 row affected)
Transaction Committed

Completion time: 2025-01-04T18:41:25.3732317-05:00
*/

 select * from Accounts

 /*

 Deliberate error:-

  update Accounts set balance=balance+100 where id='A'  ( for int substituted nvarchar)


(1 row affected)

(0 rows affected)
Transaction Rolled back

Completion time: 2025-01-04T18:43:09.2911723-05:00
*/

select * from Accounts










