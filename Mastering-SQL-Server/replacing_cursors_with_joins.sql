-------------------- Replacing Cursors with Joins------------------------------

/*
In the cursors implementation, the example took around 45 seconds to execute
on my machine. We will re-write the query using join to improve the performance
of the query.
*/

Update tblProductSales
set UnitPrice = 
 Case 
  When Name = 'Product - 55' Then 55
  When Name = 'Product - 65' Then 65
  When Name like 'Product - 100%' Then 1000
  else UnitPrice
 End     
from tblProductSales
join tblProducts
on tblProducts.Id = tblProductSales.ProductId
Where Name = 'Product - 55' or Name = 'Product - 65' or 
Name like 'Product - 100%'

----- Check the update changes ----

Select  Name, UnitPrice from 
tblProducts join
tblProductSales on tblProducts.Id = tblProductSales.ProductId
where (Name='Product - 55' or Name='Product - 65' or 
Name like 'Product - 100%')

select top 10* from tblProductSales

/*
When I executed this script on my system it took less than 1 second whereas the
same thing using a cursor took 45 seconds.

Just imagine the kind of impact cursors have on performance. Cursors should be
used as your last option.

Most of the times cursors can be very easily replaced using joins

*/

------ The same query if I execute without the where clause ------

Update tblProductSales
set UnitPrice = 
 Case 
  When Name = 'Product - 55' Then 55
  When Name = 'Product - 65' Then 65
  When Name like 'Product - 100%' Then 1000
  else UnitPrice
 End     
from tblProductSales
join tblProducts
on tblProducts.Id = tblProductSales.ProductId

/* It still executes faster because of the usage of join
its much faster than cursor
*/



