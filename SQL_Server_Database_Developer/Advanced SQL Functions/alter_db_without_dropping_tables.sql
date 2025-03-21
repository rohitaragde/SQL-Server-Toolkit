---------------------- Alter database columns without dropping the tables ---------------------------

select * from tblEmployee;

select gender,sum(salary) as Total
from tblEmployee
group by gender;

EXEC sp_help 'dbo.tblEmployee';

alter table tblEmployee
alter column salary int;




