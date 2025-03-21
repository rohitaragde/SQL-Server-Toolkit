---------------------------  Transactions in SQL Server -----------------------------------------
/*A transaction is a group of commands that change the data stored in the database
A transaction is treated as a single unit
A transaction ensures that either all the commands succeed or none of them
If one of the commands in the transaction fails all of the commands fail and any data that was modified 
in the database is rolledback.In this way transactions maintain the integrity of the database.
*/

select * from tblProduct;

Begin Transaction 
update tblProduct
set QntyAvailable=750 where ProductId=1;

Rollback transaction;


Begin Transaction;
commit transaction;




select * from tblMailingAddress;
select * from tblPhysicalAddress;

update tblMailingAddress
set city='LONDOOON'
where AddressID=1;

update tblPhysicalAddress
set city='LONDOOON'
where AddressID=1;

spUpdateAddress;



