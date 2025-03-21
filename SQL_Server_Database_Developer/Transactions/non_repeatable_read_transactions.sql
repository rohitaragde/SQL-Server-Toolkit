------------------------------ Non repeatable read --------------------------------------------

--- Non repeatable read happens when one transaction reads the same data twice and another transaction
--- updates that data in between first and second read of the transaction one --------------------

select * from tblInventory;

------- Transaction 01 --------------------
set Transaction isolation level repeatable read

Begin Transaction
select itemsInStock from tblInventory where id=1

waitfor delay '00:00:10'

select itemsInStock from tblInventory where id=1

commit transaction




