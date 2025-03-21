---------------------- Transaction 02 --------------------------------

Begin Transaction
update tblInventory
set itemsInStock=5
where id=1;

select itemsInStock
from tblInventory
Commit Transaction