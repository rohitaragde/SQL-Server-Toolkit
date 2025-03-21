------------------------------ Correlated Subqueries -------------------------------------------

select * from tblProductsN;
select * from tblProductSalesN;

--------------------------- Uncorrelated subquery----------------------------------
/* The subquery does not depend on the results of the outer query
the subquery can be executed independently*/

select id,name,description
from tblProductsN where id not in (select distinct productid from tblProductSalesN);

select * from tblProductSalesN;

----------------------- Correlated subquery---------------------------
/* The subquery depends on the outer query for its values
and hence its known as correlated subquery----------
they are executed once for every row  that is selected by the outer query
it cannot be executed independently of the outer query*/

select name,
(select sum(quantitysold) from tblProductSalesN where productid=tblProductsN.id) as qtysold
from tblProductsN;


