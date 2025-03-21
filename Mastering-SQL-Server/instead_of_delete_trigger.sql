-------------------- Instead of Delete Trigger -------------------------------

select * from vW_EmpDept

select * from tblEmployee0001

insert into tblEmployee0001 values(10,'Rohit',20000,'Male',1)
insert into tblEmployee0001 values(20,'Vasant',30000,'Male',2)
insert into tblEmployee0001 values(30,'Keyur',40000,'Male',3)
insert into tblEmployee0001 values(40,'Mrunal',50000,'Female',4)
insert into tblEmployee0001 values(50,'Geeta',65000,'Female',4)

select * from tblDept


delete from vW_EmpDept where id=2

/*
Msg 4405, Level 16, State 1, Line 10
View or function 'vW_EmpDept' is not updatable because the modification affects multiple base tables.

Completion time: 2024-08-30T16:55:34.3428346-04:00
*/

alter trigger tr_vWEmployeeDetails_InsteadOfDelete
on vW_EmpDept
instead of delete
as
begin
     /*delete tblEmployee0001
	 from  tblEmployee0001
	 join deleted
	 on tblEmployee0001.id=deleted.id*/

	 --- Subquery
	 Delete from tblEmployee0001 where id in(select id from deleted) 

end

delete from vW_EmpDept where id in(30,40)

/* Note:- In most cases Joins are faster than subqueries. However, In cases,
          where you only need a subset of records from a table that you are joining
		  with, subqueries can be faster

For instance you have 2 tables one small and other one is a huge table having
millions of records and you just want a subset of data in such case from a
performance standpoint subqueries perform better.
*/





/*
    Trigger					Inserted or Deleted?
1) Intead of Insert        Deleted table is always empty and the INSERTED table contains
                           the newly inserted data.

2) Instead of Delete       Inserted table is always empty and the DELETED table contains
	                       the rows deleted.

3) Instead of Update       Deleted table contains old data(before update) and inserted
                           table contains new data (updated data).

*/



