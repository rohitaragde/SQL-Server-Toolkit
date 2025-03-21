------------------------ Instead of Insert Trigger ------------------------------

/* Instead of triggers fires instead of the triggering action.
   (INSERT, UPDATE and DELETE)*/

select * from tblEmployee0001

select * from tblDept

create view vW_EmpDept
as
select e.id,e.name,e.gender,d.deptname
from tblEmployee0001 e join tblDept d
on e.departmentid=d.deptid

select * from vW_EmpDept

insert into vW_EmpDept values(7,'Valarie','Female','IT')

/*
Msg 4405, Level 16, State 1, Line 18
View or function 'vW_EmpDept' is not updatable
because the modification affects multiple base tables.
Completion time: 2024-08-28T20:24:55.4696500-04:00
*/

/* In the above scenario we can see that we created a table based on
   joining two base tables employee and department but when we try to
   insert a new row in the view it gives error saying it affects multiple
   tables and we can resolve this issue using Instead of Triggers*/

create trigger tr_vWEmployeeDetails_InsteadofInsert
on vW_EmpDept
instead of insert
as
begin
    select * from inserted
	select * from deleted 
end

/* Now when you try to execute the insert statement it wont thrown an error
   and execute the trigger instead of the insert statement*/

insert into vW_EmpDept values(7,'Valarie','Female','IT')

alter trigger tr_vWEmployeeDetails_InsteadofInsert
on vW_EmpDept
instead of insert
as
begin
      declare @deptid int
	  -- Check if there is a valid departmentid for the given departmentname

	  select @deptid=deptid 
	  from tblDept
	  join inserted 
	  on inserted.deptname=tblDept.deptname

	  --- if departmentId is NULL throw an error and stop processing

	  if(@deptid is null)
	  Begin 
	        Raiserror('Invalid Department Name, Statement Terminated',16,1)
			return
	  End 

	  --- Finally insert into tblEmployee table ----
	  insert into tblEmployee0001(id,name,gender,departmentid)
	  select id,name,gender,@deptid
	  from inserted
end

insert into vW_EmpDept values(7,'Valarie','Female','workrjkfk')

/*
For Junk values
Msg 50000, Level 16, State 1, Procedure tr_vWEmployeeDetails_InsteadofInsert, Line 18 [Batch Start Line 72]
Invalid Department Name, Statement Terminated

(1 row affected)

Completion time: 2024-08-28T20:48:25.7163611-04:00
*/

/* When you give proper department name 
  it gets inserted*/


insert into vW_EmpDept values(7,'Valarie','Female','IT')

select * from tblEmployee0001

select * from tblDept

select * from vW_EmpDept