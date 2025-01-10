-------------------------------- Recursive CTE Question--------------------------

create table numbers(n int)

insert into numbers values(1),(2),(3),(4),(5)
insert into numbers values(9)

select * from numbers


with cte as
(
  select n, 1 as num_counter from numbers 
  union all
  select n,num_counter+1 as num_counter from cte 
  where num_counter+1<=n
)

select n from cte order by n


---------------------------- Without Recursive CTE ----------------------

select n1.n,n2.n from numbers n1 inner join numbers n2
on n1.n>=n2.n 
order by n1.n,n2.n 


------------------- Recrsive CTE +  Join ---------------

with cte as
(
select max(n) as n from numbers 
union all
select n-1 from cte where n-1>=1
)
select n1.n,n2.n from numbers n1 inner join cte n2
on n1.n>=n2.n 
order by n1.n,n2.n 

--------------------- Approach 03 ( CTE + JOIN )------------------
with cte as
(
  select row_number() over(order by (select null)) as n
  from sys.all_columns
)

select n1.n,n2.n from numbers n1 inner join cte n2
on n1.n>=n2.n 
where n2.n<=(select max(n) from numbers)
order by n1.n,n2.n 


