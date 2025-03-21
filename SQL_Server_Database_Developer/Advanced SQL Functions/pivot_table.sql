----------------------Pivot Operator in SQL---------------------------------

--- Pivot operator is used to turn unique values from one column into multiple columns
-- in the output thereby effectively rotating the table


select * from SalesInfo

-- Group by Query
select SalesCountry,SalesAgent,sum(SalesAmount) as total
from SalesInfo
group by SalesCountry,SalesAgent
order by SalesCountry,SalesAgent

--- Pivot Query

select SalesAgent, UK,USA,Europe
from SalesInfo
PIVOT
(
    sum(salesamount)
	for SalesCountry
	in([USA],[UK],[Europe])
)
as PivotTable 

------ Issue because of id column so we get a lot of nulls because we directly retrieve-------
----- To resolve it utilize the derived table---------------------------------

select SalesAgent,USA,UK,Europe
from
(
   select SalesAgent,SalesCountry,SalesAmount 
   from SalesInfo
) as SourceTable
PIVOT
(
    sum(salesamount)
	for SalesCountry
	in([USA],[UK],[Europe])
)
as PivotTable





