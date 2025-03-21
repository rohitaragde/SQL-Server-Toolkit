-------------------------- Rank(),Dense_Rank() and Row_Number()---------------------
/*

ROW_NUMBER():- ROW_NUMBER() returns a sequential integer for every row in our partition.
ROW_NUMBER() starts over again at one when SQL encounters a new partition.

RANK():- The RANK() function behaves like ROW_NUMBER() in that it returns a ranking based on the ORDER BY; however, there is one significant difference. 
RANK() distinguishes ties within our partition, while ROW_NUMBER() does not

DENSE_RANK():- The next function is almost identical to RANK(),
except for one big difference: DENSE_RANK() doesn't allow gaps

*/


select * from emp;

select emp_id,emp_name ,department_id,
salary,
row_number() over(partition by department_id order by salary desc) as rn,
rank() over(partition by department_id order by salary desc) as rn,
dense_rank() over( partition by department_id order by salary desc)
as rnk from emp

select * from (
select emp_id,emp_name ,department_id,
salary,
rank() over(partition by department_id order by salary desc) as rnk
from emp)a
where rnk=1;




