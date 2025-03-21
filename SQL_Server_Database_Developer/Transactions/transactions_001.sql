---------------------Transactions in SQL Server----------------------------

select * from tblProduct;

Begin Transaction
update TblProduct set QntyAvailable=300 where ProductId=1
commit Transaction

Rollback Transaction

