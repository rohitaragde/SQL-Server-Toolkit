------------------------ Self Joins ------------------------------------

/* Self join basically means joining a table with itself.

   Self join is not a seperate type of join.

   It can be classified under any type of join:-
   a) Inner
   b) Outer(Left,Right,Full)
   c) Cross Joins

*/


select * from tblEmployee;

create table tblEmployee0001
(employeeid int primary key,
empname varchar(12),
managerid int);

insert into tblEmployee0001 values(1,'Mike',3);
insert into tblEmployee0001 values(2,'Rob',1);
insert into tblEmployee0001 values(3,'Todd',NULL);
insert into tblEmployee0001 values(4,'Ben',1);
insert into tblEmployee0001 values(5,'Sam',1);

select * from tblEmployee0001;

----- Dispaying Employees Names along with their Managers ----
select e.empname as employee, m.empname as manager
from tblEmployee0001 e left join  tblEmployee0001 m
on e.managerid=m.employeeid;


---- Inner Self Join-----
/* It does not display the non matching records*/
select e.empname as employee, m.empname as manager
from tblEmployee0001 e inner join  tblEmployee0001 m
on e.managerid=m.employeeid;


--- Cross Self join--------
/* Since we are self joining employee table to itself
and it has 5 records so 5*5=25 and hence cross join 
gives 25 records.*/

select e.empname as employee, m.empname as manager
from tblEmployee0001 e cross join  tblEmployee0001 m


