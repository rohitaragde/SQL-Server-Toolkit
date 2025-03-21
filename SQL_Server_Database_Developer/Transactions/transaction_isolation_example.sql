   -------- Isolated Transaction Implementations --------------------------------
--- Main Window 01-------

select * from TblProduct

begin transaction
update TblProduct
set QntyAvailable=350
where ProductId=1;

---- Window 02--------------
select * from TblProduct

update TblProduct
set QntyAvailable=450
where ProductId=1;

/*Since the default isolation level is read committed 
the transactions are executed in isolation and no
other transaction can interfere when one transaction
is executing.*/

/*
But if you try to retrieve the record which is not being updated
it will be retrieved thats why transaction isloation it locks
the row being updated by the transaction to avoid reading 
uncomitted data and to do os it enforces locking mechanism
*/

