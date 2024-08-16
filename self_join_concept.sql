
------------------------------ Self Join Concept ---------------------------------

/* A Self Join is a unique type of join in SQL where a table is joined with itself.
It's particularly useful when you need to compare rows within the same table. 
For instance, if you have a table with employee data and you want to list employees
along with their managers, a self join can be used to create that relationship
within the same table

*/

create table emp
(emp_id int primary key,
 emp_name varchar(10),
 salary int,
 manager_id int);

 insert into emp values(1,'Ankit',10000,4);
 insert into emp values(2,'Mohit',15000,5);
 insert into emp values(3,'Vikas',10000,4);
 insert into emp values(4,'Rohit',5000,2);
 insert into emp values(5,'Mudit',12000,6);
 insert into emp values(6,'Agam',12000,2);
 insert into emp values(7,'Sanjay',9000,2);
 insert into emp values(8,'Ashish',5000,2);

 select * from emp;

---------- Find employees earning more salary than their managers ----------------

select e.emp_id,e.emp_name as 'Employee Name',
       m.emp_id,m.emp_name as 'Manager Name',
	   e.salary  as 'Employee Salary',
	   m.salary as 'Manager Salary'
from emp e join emp m
on e.manager_id=m.emp_id
where e.salary>m.salary;













