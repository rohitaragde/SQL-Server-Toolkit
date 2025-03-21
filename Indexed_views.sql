------------------------------ Indexed Views-----------------------------------
/* 
Indexed View:-

a) A standard or non-indexed view is just a stored sql query. when we try to retrieve
   data from a view, the data is actually retrieved from the underlying base tables.
   
 b) So, A view is just a virtual table and it does not store any data by default.

 c) However, when you create an index,on a view, the view gets materialized. This means,
 the view is now capable of storing data.

 In SQL Server we call them Indexed View and in Oracle Materialized Views
 */

select * from tblProducts010
select * from tblProductSales010

/* Guidelines for creating Indexed Views

1) The view should be created with SchemaBinding options
2) If an Aggregate function in the select list, references an expression, and if there
   is a possibility for that expression to become NULL then a replacement value
   should be specified.
3) If 'GROUP BY' is specified the view select list must contain a COUNT_BIG(*) expression
4) The base tables in the view should be referenced with 2 part name
*/



create view vWTotalSalesByProduct
with SchemaBinding
as
select productname,
sum(isnull((quantitysold*unitprice),0)) as TotalSales,
COUNT_BIG(*) as TotalTransactions
from dbo.tblProductSales010
join dbo.tblProducts010
on dbo.tblProducts010.productid=dbo.tblProductSales010.productid
group by productname

select * from vWTotalSalesByProduct

/* When you create this view and retrieve data from this view
still you will have to compute all the calculations and perform
joins from the base tables itself*/

create unique clustered index UIX_vWTotalSalesByProduct_Name
on vWTotalSalesByProduct(productname)

/* But when you create the index on the view it becomes
  materialized view or indexed view wherein now all the
  computations are happening on the index itself and
  not on the base table.

  Also, anytime a row is added into any of the base tables
  the view is also re-computed and updates as well
  
  So, Indexed views or Materialized views can significantly
  improve the performance of the queries

  Indexed views are mostly used in OLAP (historical data) systems where data
  is not changed frequently.

  It is not applicable in OLTP systems because the data in indexed views
  keep changing and the cost of re-computing will be much more.

  Also, the cost of maintaining indexed views is much more than the cost
  of maintaining table indexes.

  */









  








