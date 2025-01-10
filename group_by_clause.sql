--------------------------- All About Group By----------------------------

/* The Group By clause is used to group a selected set of rows into a set of
summary rows by the values of one or more columns or expressions. it is always
used in conjunction with one or more aggregate functions.*/

select * from tblEmployee;

select max(salary) from tblEmployee;

---- Basic Group by clause---

select city,
sum(salary) as totalsalary
from tblEmployee group by city;

--- Multiple columns group by ----
select city,
gender,
sum(salary) as totalsalary
from tblEmployee group by city,gender;

--- Multiple columns and multiple aggregate functions---
select city,
gender,
sum(salary) as totalsalary,
count(id) as totalemployees
from tblEmployee group by city,gender;


---------- having clause ------

select city,
gender,
sum(salary) as totalsalary,
count(id) as [total employees] 
from tblEmployee group by city,gender
having sum(salary)>10000;


---- for alias example -----
select city,
gender,
sum(salary) as totalsalary,
count(id) as [total employees]  --- in case of space in alias use square brackets --
from tblEmployee group by city,gender;

/*
where clause and having clause are both used to filter the rows.
The where clause is used to filter the selected rows based on some condition
and then grouped.


Having clause takes the grouped records and then filter 
so having is filtered for each group whereas where is grouped and then filtered

a) Where clause can be used with select,insert,update statements whereas
having clause can only be used with the select clause

b) where filters rows before aggregation(grouping) whereas having clause
filters groups after the aggregations are performed

c) Aggregate functions cannot be used in the where clause unless it is in a 
subquery contained in a having clause whereas aggregate functions can be used
in having clause

*/

---- where vs having ------

select city,
gender,
sum(salary) as totalsalary,
count(id) as [total employees] 
from tblEmployee
where gender='Male'
group by city,gender

select city,
gender,
sum(salary) as totalsalary,
count(id) as [total employees] 
from tblEmployee
group by city,gender
having gender='Male';





