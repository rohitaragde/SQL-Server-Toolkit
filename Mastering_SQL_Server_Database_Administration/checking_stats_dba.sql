set statistics IO on;

create table emp19
(empnumber int primary key,
 empname varchar(20));



--- to clear cache and drop buffers ---
dbcc freeproccache;
dbcc dropcleanbuffers;

select * from emp19 where empnumber=1000

