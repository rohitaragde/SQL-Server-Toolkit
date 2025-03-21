--------------------------- Leetcode 185 ------------------------------------

create table EmpF
(id int primary key,
 nnames varchar(10),
 salary int,
 deptid int,
 foreign key(deptid) references DeptF(deptid))

 /*Write a solution to find the employees who are high earners
 in each of the departments.
Return the result table in any order.*/

 create table DeptF
 (deptid int primary key,
  deptname varchar(10));

  insert into EmpF values(1,'Joe',85000,1);
  insert into EmpF values(2,'Henry',80000,2);
  insert into EmpF values(3,'Sam',60000,2);
  insert into EmpF values(4,'Max',90000,1);
  insert into EmpF values(5,'Janet',69000,1);
  insert into EmpF values(6,'Randy',85000,1);
  insert into EmpF values(7,'Will',70000,1);

  insert into DeptF values(1,'IT');
  insert into DeptF values(2,'Sales');

  select * from EmpF;
  select * from DeptF;

  with cte as
  (
  select e.nnames as employee,
  d.deptname as Department,
  e.salary as salary,
  dense_rank() over(partition by d.deptid  order by e.salary desc) as rnk
  from EmpF e join DeptF d 
  on e.deptid=d.deptid)

  select Department,employee,salary
  from cte
  where rnk<=3
  order by department asc,salary desc;

  









  
