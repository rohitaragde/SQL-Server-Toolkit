------------------------------------Top  5 SQL Interview Questions-------------------------------------------------------------------------

------- Q1-> Top 3 products by sales,top 3 employees by salaries 
---- within cat/dept

select * from empdummy 

-- Top 2 Highest salaried employee

select top 2* from empdummy
order by salary desc 

select * from
(
select *,
row_number() over(partition by dept_id order by salary desc) as rn,
dense_rank() over(partition by dept_id order by salary desc) as rn_dense
from empdummy) a
where rn<=2

select * from Orders11
