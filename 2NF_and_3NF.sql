------------------------ Second Normal Form (2NF) ----------------------------------

/*
A table is said to be in 2NF if:-
a) The table meets all the conditions of 1NF
b) Move redundant data to a seperate table
c) create relationships between these tables using foreign keys
*/


create table Not2NFEmpDept
(empid int primary key,
 employeename varchar(10),
 gender varchar(7),
 salary int,
 deptname varchar(4),
 depthead varchar(7),
 deptlocation varchar(10))

 insert into Not2NFEmpDept values(1,'Sam','Male',4500,'IT','John','London') 
 insert into Not2NFEmpDept values(2,'Pam','Female',2300,'HR','Mike','Sydney') 
 insert into Not2NFEmpDept values(3,'Simon','Male',1345,'IT','John','London') 
 insert into Not2NFEmpDept values(4,'Mary','Female',2567,'HR','Mike','Sydney') 
 insert into Not2NFEmpDept values(5,'Todd','Male',6890,'IT','John','London') 

 
 select * from Not2NFEmpDept


 /* Problems of Data Redundancy

 a) Disk Space  Wastage
 b) Data Inconsistency
 c) DML queries can be slow

*/

----- Table Design in Second Normal Form (2NF ) -------

create table Dept2NF
(deptid int primary key,
 deptname varchar(5),
 depthead varchar(8),
 deptlocation varchar(10))

 insert into Dept2NF values(1,'IT','John','London')
 insert into Dept2NF values(2,'HR','Mike','Sydney')

 select * from Dept2NF

create table Emp2NF
(empid int primary key,
 employeename varchar(12),
 gender varchar(7),
 salary int,
 deptid int,
 foreign key(deptid) references Dept2NF(deptid))


 insert into Emp2NF values(1,'Sam','Male',4500,1)
 insert into Emp2NF values(2,'Pam','Female',2300,2)
 insert into Emp2NF values(3,'Simon','Male',1345,1)
 insert into Emp2NF values(4,'Mary','Female',2567,2)
 insert into Emp2NF values(5,'Todd','Male',6890,1)

 select * from Emp2NF
 select * from Dept2NF

 /* The above table design comforms to be in the second normal form because:-

 a) Its in first normal form as its atomic and no repeated groups
 b) It is made into second normal form by reducing the redundancy. previously,
    we used to have 3 redundate columns now we just have one which we need
	to establish the PK-FK relationship
 c) We moved the redundant data into seperate table and now we have 2 independent
    tables one for dept and one for employee and we also have a PK-FK relationship
	defined so it follows the 2NF criteria.
 d) It also reduces data inconsistency as now if you have to update the deptheadname
    you just refer the dept table and update it and its referred to the emp table
	and its not like we will update the few and not the others like in previous case
	and hence data inconsistency is removed as we will either update or we wont update it.

*/

------- Third Normal Form ( 3NF) -------

/*
A table is said to be in 3NF if the table:-
a) Meets all the conditions of 1NF and 2NF
b) does not contain columns or attributes that are not fully dependent upon
   the primary key.
*/

create table EmpDeptN3NF
(empid int primary key,
 empname varchar(12),
 gender varchar(7),
 salary int,
 annualsalary int,
 deptid int)

 insert into EmpDeptN3NF values(1,'Sam','Male',4500,54000,1) 
 insert into EmpDeptN3NF values(2,'Pam','Female',2300,27600,2) 
 insert into EmpDeptN3NF values(3,'Simon','Male',1345,16140,1)
 insert into EmpDeptN3NF values(4,'Mary','Female',2567,30804,2) 
 insert into EmpDeptN3NF values(5,'Todd','Male',6890,82680,1) 

 select * from EmpDeptN3NF

 /* In the table above you can see that we have a column i.e. annualsalary
    that is not fully dependent on the PK i.e. empid rather it is
	dependent on empid and salary that means it breaks the rules of being 
	in 3NF in that case we either remove that column or move to a seperate
	table*/

--- Remove that column ----
alter table EmpDeptN3NF
drop column annualsalary

---- Moving to another table ----

/* Now we can see that we have removed the annualsalary column 
  as we know we can compute annualsalary from the salary column.
  In the below example we will see an instance of moving to
  another table.

  As we can see that we have a column DeptHead which is dependent
  on empid but it is also dependent on deptnames which violates
  3NF and hence we will be dividing this table into 2 tables.
   
  */


create table EmpDeptN3NF01
(empid int primary key,
 employeename varchar(10),
 gender varchar(7),
 salary int,
 deptname varchar(3),
 depthead varchar(7))

 insert into EmpDeptN3NF01 values(1,'Sam','Male',4500,'IT','John')
 insert into EmpDeptN3NF01 values(2,'Pam','Female',2300,'HR','Mike')
 insert into EmpDeptN3NF01 values(3,'Simon','Male',1345,'IT','John')
 insert into EmpDeptN3NF01 values(4,'Mary','Female',2567,'HR','Mike')
 insert into EmpDeptN3NF01 values(5,'Todd','Male',6890,'IT','John')

 select * from EmpDeptN3NF01

 /* we can move the columns which are not fully dependent on the empid 
  into its own table which in this case are depthead and hence we
  have a seperate table for emp and dept*/


create table Empp3NF
(empid int primary key,
 employeename varchar(10),
 gender varchar(7),
 salary int,
 deptid int,
 foreign key(deptid) references Deptp3NF(deptid))

 create table Deptp3NF
 (deptid int primary key,
  deptname varchar(10),
  depthead varchar(7))

insert into Deptp3NF values(1,'IT','John')
insert into Deptp3NF values(2,'HR','Mike')

insert into Empp3NF values(1,'Sam','Male',4500,1)
insert into Empp3NF values(2,'Pam','Female',2300,2)
insert into Empp3NF values(3,'Simon','Male',1345,1)
insert into Empp3NF values(4,'Mary','Female',2567,2)
insert into Empp3NF values(5,'Todd','Male',6890,1)

select * from Deptp3NF
select * from Empp3NF

/* Now the above table is in 3NF as it meets all the conditions of 1NF and 2NF
  and secondly we moved the columns which were not fully dependent on the 
  primary key on its own seperate columns*/










