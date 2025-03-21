select * from empnewtesting

--- SQL query to find employees who joined before their managers-----

select e.name from empnewtesting e join empnewtesting m
on e.managerid=m.empid
where e.salary<m.salary;



