------------------------ After update trigger -----------------------------------

select * from tblEmployee0001
select * from tblauditdata

/* The after update trigger for UPDATE event, makes use of both inserted and deleted
  tables. The inserted tables contains the updated data and the deleted table
  contains the old data*/




alter trigger tr_tblEmployee_ForUpdate
on tblEmployee0001
for update
as 
Begin
      declare @id int
	  declare @oldname nvarchar(20), @newname nvarchar(20)
	  declare @oldsalary int, @newsalary int
	  declare @oldgender nvarchar(20), @newgender nvarchar(20)
	  declare @olddeptid int, @newdeptid int

	  declare @auditstring nvarchar(1000)

	  select * into #TempTable from inserted

	  while(exists(select id from #TempTable))
	  Begin
	        set @auditstring= ''

			select top 1 @id=id, @newname=name,@newgender=gender,@newsalary=salary,
			@newdeptid=departmentid
			from #TempTable

	        select @oldname=name,@oldgender=gender,@oldsalary=salary,
			       @olddeptid=departmentid from deleted where id=@id

-- Build the audit string dynamically           
            Set @AuditString = 'Employee with Id = ' + Cast(@Id as nvarchar(4)) + ' changed'
            if(@OldName <> @NewName)
                  Set @AuditString = @AuditString + ' NAME from ' + @OldName + ' to ' + @NewName
                 
            if(@OldGender <> @NewGender)
                  Set @AuditString = @AuditString + ' GENDER from ' + @OldGender + ' to ' + @NewGender
                 
            if(@OldSalary <> @NewSalary)
                  Set @AuditString = @AuditString + ' SALARY from ' + Cast(@OldSalary as nvarchar(10))+ ' to ' + Cast(@NewSalary as nvarchar(10))
                  
     if(@OldDeptId <> @NewDeptId)
                  Set @AuditString = @AuditString + ' DepartmentId from ' + Cast(@OldDeptId as nvarchar(10))+ ' to ' + Cast(@NewDeptId as nvarchar(10))
           
            insert into tblauditdata values(@AuditString)
            
            -- Delete the row from temp table, so we can move to the next row
            Delete from #TempTable where Id = @Id
      End
	End



update tblEmployee0001 set name='Padmini',salary=60000,gender='Female'
where id=3

select * from tblEmployee0001
select * from tblauditdata