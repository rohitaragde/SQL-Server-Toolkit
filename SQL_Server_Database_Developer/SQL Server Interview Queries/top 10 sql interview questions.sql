-------------------------Top 10 SQL Interview Questions---------------------------

--Q1-> How to find duplicates in a given table

select * from EmpTestNew

select emp_id,count(*) as emp_count
from EmpTestNew
group by emp_id
having count(*)>1

-- Q2-> How to delete duplicates--------------------------

with cte as
(select *,row_number() over(partition by emp_id order by emp_id) as rn from 
EmpTestNew 
)

--- Q3-> Difference between union and union all-------------------------------


select manager_id from EmpTestNew
union
select manager_id from EmpTestNew1


---- Q4->---differnece between rank,row_number and dense_rank

---- Refer the sql files for this

---- Q5-> Employees who are not present in the department table

select * from EmpTestNew  

select * from DeptTestNew

select * from EmpTestNew 
where dept_id not in( select dept_id from DeptTestNew)

select * from EmpTestNew e 
left join DeptTestNew d
on e.dept_id=d.dept_id
where d.dept_id is null or d.dept_name is null--- ( Better performance for big tables)


-------Q6-> second highest salary  in each department
SELECT dept_id, MAX(salary) AS second_highest_salary
FROM EmpTestNew
WHERE salary < (
    SELECT MAX(salary)
    FROM EmpTestNew AS e
    WHERE e.dept_id = EmpTestNew.dept_id
)
GROUP BY dept_id;

 select * from EmpTestNew order by dept_id asc

with ranked_employees as
(
select emp.*,dense_rank() over(partition by dept_id order by salary desc) as rnk
from EmpTestNew emp
)

select * from ranked_employees where rnk=2
 

 select * from EmpTestNew 
 order by dept_id asc

-------------Q7-> Find all transactions done by Shilpa-------------

select * from OrdersT
where upper(customer_name)='SHILPA'

---( By default SQL Server is case-insensitive but otherwise for------
--- case senitivity we must use upper function for string comparision--


--------------Q8-> self join manager salary> employee salary

select * from EmpTestNew

select e.emp_name from EmpTestNew e join EmpTestNew m
on e.manager_id=m.emp_id
where e.salary>m.salary

---------------------- Q9->left join/inner join

----------------------- Q10-> update query to swap gender

select * from ordersT  

update ordersT
set customer_gender= case when customer_gender='Male' then 'Female'
	   when customer_gender='FeMale'then 'Male' end






  









select employeeid,count(1) as "EmpCount" from EmpTest
group by employeeid 
having count(1)>1