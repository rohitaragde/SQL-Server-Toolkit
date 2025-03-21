----------------------- Corelated Subqueries ---------------------------

/*

if the subquery depends on the outer query for its values, then that 
suquery is called as corelated subquery

In the where clause of the subquery below, "ProductId" column got its
value from the tblProducts table that is present in the outer query.
*/

--- Correlated Subquery ----
select [name],
(select sum(quantitysold) from tblProductSales
 where productid=tblProducts.id) as TotalQuantity
 from tblProducts 
order by name 

/* So here the subquery is dependent on the outer query for its value,
   hence this subquery is a correlated subquery

Correlated subqueries get executed, once for every row that is selected
by the outer query

Correlated subquery cannot be executed independently of the outer query
whereas a non-correlated subquery can be executed independently of the 
outer query.

*/

select * from tblProducts
select * from tblProductSales

---- Non-Correlated Subquery
select id,[name],[description] 
from tblProducts where id not in (select distinct productid from tblProductSales)

/* The subquery is not dependent on the outer query for its values
and hence its called as a non correlated subquery
*/

--- Correlated Subquery ----

select [name],
(select sum(quantitysold) from tblProductSales
 where productid=tblProducts.id) as TotalQuantity
 from tblProducts 
order by name

/* When we try to execute the subquery independently 
we get the following error:-

Msg 4104, Level 16, State 1, Line 42
The multi-part identifier "tblProducts.id" could not be bound.

Completion time: 2024-10-02T22:33:03.8355997-04:00

*/

/* A correlated subquery gets executed for every row
that is selected by the outer query*/



