---------------------------- Database Normalization -------------------------------

/* 

Database Normalization:- It is the process of organizing data to minimize data
                         redundancy (data duplication) which in turn ensures
						 data consistency.


Problems of Data Redundancy:-

a) DiskSpace Wastage
b) Data Inconsistency
c) DML Queries can become slow

Database Normalization is a step by step process. There are 6 normal forms, First
Normal Form ( 1NF) thru Sixth Normal Form ( 6NF). Most databases are in third
normal form ( 3NF). These are certian rules that each normal form should follow.
*/

create table tblEmpMain
(empname varchar(10),
 gender varchar(8),
 salary int,
 deptname varchar(12),
 depthead varchar(7),
 deptlocation varchar(12))

 insert into tblEmpMain values('Sam','Male',4500,'IT','John','London')
 insert into tblEmpMain values('Pam','Female',2300,'HR','Mike','Sydney')
 insert into tblEmpMain values('Simon','Male',1345,'IT','John','London')
 insert into tblEmpMain values('Mary','Female',2567,'HR','Mike','Sydney')
 insert into tblEmpMain values('Todd','Male',6890,'IT','John','London')

 select * from tblEmpMain

 /* 

 In the above employee table we can see that along with the employee
 information we also have department information that includes
 deptname, depthead and deptlocation.

 so for departmentname as IT we can see that the depthead and
 deptlocation is repeated for 3 employees having the same department
 which increases data redundancy by including duplicated data
 which inturn results in a lot of diskspace wastage.

 Also, there is a lot of data inconsistency that takes place,
 For instance, we need to change the depthead of IT to Steve
 and there are 50K rows and we forget to change a few rows
 just imagine what will happen if there are 1M rows
 its a lot of data data inconsistency that takes place

 DML queries become slow as well for instance we have 1M
 records and we need to update the depthead from Mike to Steve
 we need to update 1M records which is a massive DML which
 will ve slow
 */

 ----------- Normalized Table Design -------------------


---1 Drop the Mian table

drop table tblEmpMain

--- 2 Create two seperate tables one for employee and one for department

create table tblEmpMain
(employeeid int primary key,
 employeename varchar(12),
 gender varchar(7),
 salary int,
 deptid int,
 foreign key(deptid) references tblDeptMain(deptid))


create table tblDeptMain
(deptid int primary key,
 deptname varchar(10),
 depthead varchar(12),
 deptlocation varchar(10))


 insert into tblDeptMain values(1,'IT','John','London') 
 insert into tblDeptMain values(2,'HR','Mike','Sydney') 

 insert into tblEmpMain values(1,'Sam','Male',4500,1)
 insert into tblEmpMain values(2,'Pam','Female',2300,2)
 insert into tblEmpMain values(3,'Simon','Male',1345,1)
 insert into tblEmpMain values(4,'Mary','Female',2567,2)
 insert into tblEmpMain values(5,'Todd','Male',6890,1)

 select * from tblDeptMain
 select * from tblEmpMain

 /* The above tables are the normalized tables which reduces redunandancy
   utilized less disk space and DMLS are also fast*/

---------------------- First Normal Form ( 1NF ) -------------------------------

/*

A table is said to be in 1NF if:-
a) the data in each column should be atomic. No mutiple values,seperated by comms
b) The table does not contain any repeating column groups
c) Identify each record uniquely using primary key
*/

--- Non-Atomic Employee Column ----

create table NAEmp
(deptname varchar(3),
 employee varchar(15))

insert into NAEmp values('IT','Sam,Mike,Shan')
insert into NAEmp values('HR','Pam')

select * from NAEmp

---- Problems of Non-Atomic Columns ----

/* it is not possible to SELECT,INSERT,UPDATE and DELETE just one employee*/


---- No Repeating Column Groups ---

create table RGEmp
(deptname varchar(7),
 employee1 varchar(10),
 employee2 varchar(12),
 employee3 varchar(13))

insert into RGEmp values('IT','Sam','Mike','Shan')
insert into RGEmp values('HR','Pam','','')

select * from RGEmp 

--- Problems of Non-Repeating Groups ----

/* More than 3 employees:- Table structure change required
   Less than 3 employees:- Wasted Diskspace
*/


---- First Normal Form ----------

create table FNFDept
(deptid int primary key,
 deptname varchar(12))

create table FNFEmp
(deptid int,
 employee varchar(10),
 foreign key(deptid) references FNFDept(deptid))

 insert into FNFDept values(1,'IT')
 insert into FNFDept values(2,'HR')

 insert into FNFEmp values(1,'Sam')
 insert into FNFEmp values(1,'Mike')
 insert into FNFEmp values(1,'Shan')
 insert into FNFEmp values(2,'Pam')

 select * from FNFDept
 select * from FNFEmp
















