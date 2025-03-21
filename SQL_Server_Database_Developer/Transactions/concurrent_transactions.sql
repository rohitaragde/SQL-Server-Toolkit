--------------------------------- Transactions ----------------------------------------------------------

--- A transaction is a group of commands that change the data stored in the database. A transaction is
--- treated as a single unit of work --
--- it ensures that either all of the commands are succeeded or none of them----
--- If one of the commands fail all of them will fail and data that was modified will be rolled back
--- In this way transactions maintain the integrity of the data in the database---

create table Accounts01
(id int primary key,
AccountName varchar(10),
Balance int);

select * from Accounts01;

--- Transfer 100$ from mark to mary account

Begin try
Begin Transaction
update Accounts01 set balance=Balance-100 where id=1
update Accounts01 set balance=balance+100 where id='A'
commit Transaction
print 'Transaction Committed'
End Try
Begin Catch
rollback transaction
print 'Transaction RolledBack'
End Catch








