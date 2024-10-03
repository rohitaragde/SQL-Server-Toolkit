---------------------------- Subqueries in SQL Server --------------------------

select * from tblProducts
select * from tblProductSales

------------- Queries Using Subquery and their equivalent join alternative queries--

-- Query 01:- Write a query to retrieve products that are not at all sold?--

select id,name, description
from tblProducts
where id not in (select distinct productid from tblProductSales)

select p.id,name,description
from tblProducts p left join tblProductSales s
on p.id=s.productid
where s.productid is null

-- Query 02:- Write a query to retrieve the name and the Total Quantity Sold?--

select name,
(select sum(quantitysold) from tblProductSales  where productid=tblProducts.id) as QtySold
from tblProducts 
order by name 


select name,sum(quantitysold) as QtySold
from tblProducts p left join tblProductSales s
on p.id=s.productid
group by name

/*

From these examples, it should be clear that, A subquery is simply a 
select statement that returns a single value and can be nested inside a
select, update, insert or delete statement. it is also possible to nest
a subquery inside another subquery. According to MSDN, subqueries can be
nested upto 32 levels.

*/


/*Subqueries are always enclosed in paranthesis and are also called as 
inner queries and the query containing the subquery is called as the
outer query. The columns from a table that is present only inside a
subquery cannot be used in the select list of the outer query.
*/


select id,name, description,unitprice
from tblProducts
where id not in (select distinct productid from tblProductSales)

/*
Msg 207, Level 16, State 1, Line 47
Invalid column name 'unitprice'.

Completion time: 2024-10-02T22:17:25.8144724-04:00

*/





