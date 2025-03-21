--------------------------------- Subqueries in SQL Server ---------------------------------

select * from tblProductsN;

select * from tblProductSalesN;

select id,[name],[description] from tblProductsN
where id not in(select distinct productId from tblProductSalesN);

select t.id,[name],[description] from tblProductsN t
left join tblProductSalesN n on t.id=n.productId
where n.productid is null
order by t.id,[name];


---- to retrieve name and total qualtity sold


SELECT p.name,
       (SELECT SUM(s.quantitysold)
        FROM tblProductSalesN s
        WHERE s.productid = p.id) AS totalquantity
FROM tblProductsN p;

select name,sum(quantitysold) as totalqty
from tblProductsN t left join tblProductSalesN n
on t.id=n.productId
group by name;




select * from tblProductsN;
select * from tblProductSalesN;
