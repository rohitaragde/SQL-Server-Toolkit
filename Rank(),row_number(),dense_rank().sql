--------------------------- Rank(), Row_Number() and Dense_Rank() --------------------

/*
Rank() :- 

The RANK function in the SQL server is used to assign a rank
to each row based on its value.

The same rank is assigned to the rows which have the same values. 
The ranks may not be consecutive in the RANK() function as it adds the number 
of repeated rows to the repeated rank to calculate the rank of the next row. 

Dense_Rank():-

The DENSE_RANK() function in SQL server serves the purpose of assigning 
ranks to rows in a dataset according to specific conditions. 
Much like the RANK() function, it orders the data based on certain criteria.
However, what sets it apart is that it ensures there are no gaps between ranks
in cases where multiple rows share the same values

Row_Number():-

Numbers the output of a result set. More specifically, 
returns the sequential number of a row within a partition of a result set, 
starting at 1 for the first row in each partition.

ROW_NUMBER and RANK are similar. 
ROW_NUMBER numbers all rows sequentially (for example 1, 2, 3, 4, 5).
RANK provides the same numeric value for ties (for example 1, 2, 2, 4, 5)
*/



create table emp1
(emp_id int primary key,
 emp_name varchar(12),
 department_id int,
 salary int)

 insert into emp1 values(1,'Ankit',100,100000)
 insert into emp1 values(2,'Mohit',100,15000)
 insert into emp1 values(3,'Vikas',100,100000)
 insert into emp1 values(4,'Rohit',100,5000)
 insert into emp1 values(5,'Mudit',200,12000)
 insert into emp1 values(6,'Agam',200,12000)
 insert into emp1 values(7,'Sanjay',200,9000)
 insert into emp1 values(8,'Ashish',200,5000)

 select * from emp1


 ----- Rank(), Dense_Rank(), Row_Number() -----

 /*
 rank():- skips the rank when the same ranks are assigned in case of tie
 dense_rank(): does not skip the rank when the same ranks are assigned in
                case of tie
 row_number(): assigns sequential number to each row .
               returns the sequential number of a row within a partition of a result set
*/


 select emp_id,emp_name,department_id,salary,
 rank() over(partition by department_id order by salary desc) as rnk,
 dense_rank() over(partition by department_id order by salary desc) as dn_rnk,
 row_number() over(partition by department_id order by salary desc) as rn
 from emp1

 -- Q:- Return the highest salries employees in each department ----

 select * from
 (
 select emp_id,emp_name,department_id,salary,
        rank() over(partition by department_id order by salary desc) as rnk
from emp1 
 ) a
 where rnk=1
