--------------------------- Dirty Read -------------------------------

--- A Dirty Read happens when one transaction is permitted to read data that has been modified
-- by another transaction and has not been committed yet. In most cases this would not cause a
-- problem. However, if the first transaction is rolled back after the second transaction reads
-- the data, the second transaction has dirty data that does not exist anymore.

create table Inventory
(id int primary key,
product varchar(10),
iteminStock int);

insert into Inventory values(1,'IPhone',10);

select * from Inventory;


Begin Transaction
update Inventory set iteminStock=9 where id=1

--- Bill the customer
Waitfor Delay '00:00:15'
Rollback Transaction

----- Transaction 02---



select * from Inventory(NOLOCK) where id=1;
