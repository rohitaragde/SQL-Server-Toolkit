------------------- Union and Union All --------------------------------

/* Union and Union All operators are used to combine the results of two or more 
select queries

Union:- Returns only distinct records and is sorted as well
Union All:- Returns all the records including the duplicates and is unsorted.

For both union and union all to work the number, the datatype and
the order of the columns in the select statements should be the same.

Difference between Union and Union All

Union removes duplicates whereas Union All does not
Union has to perform distinct sort to remove duplicates which makes it
less faster than union all

Order by clause should be used only in the last select statement in the
select query.

Difference between Union and Join

Union combines the resultset of two or more select queries into a single
resultset which includes all the rows from the queries in the union where
as JOINS retrieve data from two or more tables based on the logical 
relationships between the tables.

In short, Union combines rows from 2 or more tables whereas JOINS combine
columns from 2 or more tables.
*/

select * from tblIndiaCustomers
select * from tblUKCustomers

---- Basic Union All--
select * from tblIndiaCustomers
union all
select * from tblUKCustomers

--- Basic Union ---
select * from tblIndiaCustomers
union 
select * from tblUKCustomers

/* performance of Union all is better than union 
as it does not have to check for distinct rows and
the order of the rows

We can check the performance of the query using 
quer estimator*/



-- Checking diiferent columns ( will throw error)--
/* here we have not used same columns and since we dont have email
in the second select it will fail*/

select id,name,email from tblIndiaCustomers
union all
select id,name from tblUKCustomers

---- Checking Order By Clause --

select * from tblIndiaCustomers
union 
select * from tblUKCustomers
order by name 

--- Tring Order by Clause in the first select ( will throw error) ---
/* Since its union we have to use order by after the second select
otherwise it will fail*/

select * from tblIndiaCustomers order by name 
union 
select * from tblUKCustomers


------ Union Vs Join ---------
/* Union has to have the order, no and datatype of columns 
maintained to perform the union and it selects the combined rows
whereas join selects columns based on specific join condition
no specific order has to be maintained*/

select * from tblIndiaCustomers
union all
select * from tblUKCustomers

select ind.id,uk.name,uk.email 
from tblIndiaCustomers ind
join tblUKCustomers uk on ind.id=uk.id


/* to rename columns
EXEC sp_rename 'tblUKCustomers.ukname', 'name', 'COLUMN';
*/






