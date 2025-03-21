--------------------- Instead of Update Trigger---------------------------

select * from vW_EmpDept

select * from tblEmployee0001

select * from tblDept

--- update affecting multiple base tables ---
update vW_EmpDept set name='Johny',deptname='IT' where id=1


/*
Msg 4405, Level 16, State 1, Line 9
View or function 'vW_EmpDept' is not updatable because the modification affects multiple base tables.

Completion time: 2024-08-28T21:20:43.7055880-04:00
*/

--- update affecting just one base table---
update vW_EmpDept set deptname='IT' where id=2

/* When we execute just one column it could wrong impact the data
  like in the above case we are updating the deptname to IT for the 
  id 2 but it will change the label in the dept table so we will 
  have 2 deptids as IT and wrongly update 2 different dept employees
  to IT itself which is wrong and for the same reason we will use
  Intead of Update trigger to perform the update operation correctly*/

select * from vW_EmpDept

select * from tblEmployee0001

select * from tblDept

alter Trigger tr_vWEmployeeDetails_InsteadOfUpdate
on vW_EmpDept
instead of update
as
Begin
 -- if EmployeeId is updated
 if(Update(Id))
 Begin
  Raiserror('Id cannot be changed', 16, 1)
  Return
 End
 
 -- If DeptName is updated
 if(Update(DeptName)) 
 Begin
  Declare @DeptId int

  Select @DeptId = DeptId
  from tblDept
  join inserted
  on inserted.DeptName = tblDept.DeptName
  
  if(@DeptId is NULL )
  Begin
   Raiserror('Invalid Department Name', 16, 1)
   Return
  End
  
  Update tblEmployee0001 set DepartmentId = @DeptId
  from inserted
  join tblEmployee0001
  on tblEmployee0001.Id = inserted.id
 End
 
 -- If gender is updated
 if(Update(Gender))
 Begin
  Update tblEmployee0001 set Gender = inserted.Gender
  from inserted
  join tblEmployee0001
  on tblEmployee0001.Id = inserted.id
 End
 
 -- If Name is updated
 if(Update(Name))
 Begin
    print 'Name Changed'
  Update tblEmployee0001 set Name = inserted.Name
  from inserted
  join tblEmployee0001
  on tblEmployee0001.Id = inserted.id
 End
End

update vW_EmpDept set deptname='ABCDE' where id=2

/*
Msg 50000, Level 16, State 1, Procedure tr_vWEmployeeDetails_InsteadOfUpdate, Line 25 [Batch Start Line 87]
Invalid Department Name

(1 row affected)

Completion time: 2024-08-28T22:17:32.3766524-04:00
*/

--- update affecting just one base table---
update vW_EmpDept set deptname='Payroll' where id=9
/* this worked successfully it changed only Jimmy's deptname to Payroll
  and in the emp table as well it changed jimmy's deptid to 2 and no change
  in the dept table like previously it did update everything to IT this 
  time it worked correctly*/

--- update affecting more than one base table ---
update vW_EmpDept set name='Johny',gender='Female',deptname='Payroll' where id=2


/* Previously we used to get error while updating the view referencing
multiple base tables saying cant update view as the modification
affects multiple base tables but this time it worked*/




update vW_EmpDept set name='Johny' where id=2
/* The update function returns true even if you update it with the same value
 -- If Name is updated
 if(Update(Name))
 Begin
    print 'Name Changed'
  Update tblEmployee0001 set Name = inserted.Name
  from inserted
  join tblEmployee0001
  on tblEmployee0001.Id = inserted.id


Hence Always prefer comparing the values from inserted and deleted tables
rather than using the update() function.
*/

select * from vW_EmpDept

select * from tblEmployee0001

select * from tblDept









