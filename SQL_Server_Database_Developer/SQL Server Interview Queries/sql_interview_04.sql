create table empnewtesting
(name varchar(10),
 joiningDate date,
 salary int);

 select * from empnewtesting;

 -- cumulative sum of salaries ordered by DOJ ---

 select joiningDate,sum(salary) over(order by joiningDate) as total_salaries
 from empnewtesting





