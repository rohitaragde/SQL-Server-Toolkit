------------------------------- Pivoting ----------------------------------

------------------------------ Pivot Operator ----------------------------

/* Pivot in SQL Server can be used to turn unique values in one column into multiple
columns in the output, thereby effectively rotating a table*/

create table SalesSummary1
(SalesAgent varchar(5),
 salesCountry varchar(5),
 SalesAmount int)

 insert into SalesSummary1 values('Tom','UK',200) 
 insert into SalesSummary1 values('John','US',180) 
 insert into SalesSummary1 values('John','UK',260)
 insert into SalesSummary1 values('David','India',450)
 insert into SalesSummary1 values('Tom','India',350)
 insert into SalesSummary1 values('David','US',200)
 insert into SalesSummary1 values('Tom','US',130)
 insert into SalesSummary1 values('John','India',550)
 insert into SalesSummary1 values('David','UK',220)
 insert into SalesSummary1 values('John','UK',420)
 insert into SalesSummary1 values('David','US',320) 
 insert into SalesSummary1 values('Tom','US',340)
 insert into SalesSummary1 values('Tom','UK',660)
 insert into SalesSummary1 values('John','India',430)
 insert into SalesSummary1 values('David','India',230)
 insert into SalesSummary1 values('Daivid','India',280)
 insert into SalesSummary1 values('Tom','UK',480)
 insert into SalesSummary1 values('John','US',360)
 insert into SalesSummary1 values('David','UK',140) 

 select * from SalesSummary1

 ---- Normal Group By Query --------

 select salescountry,salesagent,sum(salesamount) as total
 from SalesSummary1
 group by salescountry,salesagent
 order by salescountry,salesagent


----- Using Pivot Operator (Cross Tab Format) ---

select Salesagent,India,US,UK
from SalesSummary1
PIVOT
(
    sum(Salesamount)
	FOR SalesCountry
	IN([India],[US],[UK])
)
as pivotable


create table SalesSummary11
(id int identity(1,1) primary key,
SalesAgent varchar(5),
 salesCountry varchar(5),
 SalesAmount int)

 
 
  insert into SalesSummary11 values('Tom','UK',200) 
 insert into SalesSummary11 values('John','US',180) 
 insert into SalesSummary11 values('John','UK',260)
 insert into SalesSummary11 values('David','India',450)
 insert into SalesSummary11 values('Tom','India',350)
 insert into SalesSummary11 values('David','US',200)
 insert into SalesSummary11 values('Tom','US',130)
 insert into SalesSummary11 values('John','India',550)
 insert into SalesSummary11 values('David','UK',220)
 insert into SalesSummary11 values('John','UK',420)
 insert into SalesSummary11 values('David','US',320) 
 insert into SalesSummary11 values('Tom','US',340)
 insert into SalesSummary11 values('Tom','UK',660)
 insert into SalesSummary11 values('John','India',430)
 insert into SalesSummary11 values('David','India',230)
 insert into SalesSummary11 values('Daivid','India',280)
 insert into SalesSummary11 values('Tom','UK',480)
 insert into SalesSummary11 values('John','US',360)
 insert into SalesSummary11 values('David','UK',140)

 select * from SalesSummary11

  /* Now you can see that we have the same table but with an additional id column
    we get  a lot of NULL values that is not what we expected and the users
	are basically repeated in the output so id column's presence causes
	that output */

 select SalesAgent,US,UK,India
 from SalesSummary11
 PIVOT
 (
    sum(salesamount)
	FOR SalesCountry
	IN([India],[US],[UK])
 ) 
 as pivotable1 

 /* To correct this we use a derived table and select only the columns 
    that we need and then pivot and then we should be able to get
	the output*/

select salesagent,India,US,UK
from
 (
  select Salesagent,salescountry,salesamount 
  from SalesSummary11
 ) as SourceTable

Pivot
(
  sum(salesamount) FOR SalesCountry in (India,US,UK)
) as Pivottable 

/* Now we can see that the ouput is correctly displayed
  and the pivot operation is performed successfully
*/





