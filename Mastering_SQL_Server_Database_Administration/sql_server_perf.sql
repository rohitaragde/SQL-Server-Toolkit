CHECKPOINT;
GO
DBCC DROPCLEANBUFFERS; ----Clears query cache
GO
DBCC FREEPROCCACHE; ------- CLears execution plan cache
GO





Select count(*) from tblProducts
Select count(*) from tblProductSales

select id,name,description
from tblProducts 
where id in
(select productid from tblProductSales);

select distinct TblProducts.id,name,description
from tblProducts 
inner join tblProductSales
on tblProducts.id=tblProductSales.ProductId;