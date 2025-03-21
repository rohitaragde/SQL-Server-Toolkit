------------------------------ DML Triggers ------------------------------------

/* 

There are 3 types of triggers:-
a) DML triggers
b) DDL triggers
c) Logon trigger

DML triggers are fired automatically in response to DML events (INSERT,UPDATE,DELETE)

DML triggers can be again classifies into 2 types:-
1) After triggers(Sometimes called as FOR triggers)
2) Instead of triggers

After triggers fires after the triggering action. The INSERT,UPDATE and DELETE statements 
causes after trigger to fire after the respective statements complete execution.

INSTEAD OF triggers, fires instead of the triggering action. The INSERT,UPDATE and DELETE
stataments causes an INSTEAD OF TRIGGER to fire INSTEAD OF the respective statement
execution.
*/

create table tblEmployee0001
(id int primary key,
 name varchar(10),
 salary int,
 gender varchar(12),
 departmentid int)

  
 create table tblauditdata
 ( id int identity(1,1) primary key,
   auditdata nvarchar(1000))

 insert into tblEmployee0001 values(1,'John',5000,'Male',3) 
 insert into tblEmployee0001 values(2,'Mike',3400,'Male',2) 
 insert into tblEmployee0001 values(3,'Pam',6000,'Female',1) 
 insert into tblEmployee0001 values(4,'Todd',4800,'Male',4) 
 insert into tblEmployee0001 values(5,'Sara',3200,'Female',1) 
 insert into tblEmployee0001 values(6,'Ben',4800,'Male',3) 



 alter trigger tr_tblEmployee_ForInsert
 on tblEmployee0001
 FOR INSERT
 as
 begin
     declare @id int
	 select @id=id from inserted

	 insert into tblauditdata
	 values('New employee with id =' + cast(@id as nvarchar(5)) + ' is added at' + cast(getdate() as nvarchar(20)))
end 


create trigger tr_tblEmployee_ForDelete
 on tblEmployee0001
 FOR DELETE
 as
 begin
     declare @id int
	 select @id=id from deleted 

insert into tblauditdata
	 values('An existing employee with id =' + cast(@id as nvarchar(5)) + ' is deleted at' + cast(getdate() as nvarchar(20)))
end


insert into tblEmployee0001 values(8,'Keyur',45000,'Male',7)
delete from tblEmployee0001 where id=1

select * from tblEmployee0001
select * from tblauditdata


/*

1) The inserted table structure is similar to the  the structure of the table on the
   ON clause ( in this case tblEmployee)
2) The "inserted table" is a special table created by SQL Server for the purposes
   of triggers so its available only within the context of a trigger and if you try
   to access it outside the context of the trigger you will get an error message
  
 
 When tried to access it gives the below mentioned error:-
 
 select * from inserted

Msg 208, Level 16, State 1, Line 62
Invalid object name 'inserted'.

Completion time: 2024-08-26T19:50:44.4746130-04:00

The delete trigger is similar to insert trigger just instead of inserted we 
have a deleted table gets created within the context of the trigger 
and instead of FOR INSERT we have to mention FOR DELETE and rest of the 
structure remains the same.

so whenever we insert a row into the tblEmployee0001 table 
or delete a row from tblEmployee0001,
it adds a entry into the tblauditdata table
   */





