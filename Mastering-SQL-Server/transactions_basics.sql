---------------------------- Transactions ------------------------------------

/*
A transaction is a group of commands that change the data stored in a database.
A transaction is treated as a single unit. A transaction ensures that, either
all of the commands succeed or none of them. If one of the commands in the
transaction fails, all of the transaction fails,and any data that was modified
in the database is rolledback.In this way, transactions maintain  integrity
of data in a database

Transaction processing follows these steps:-
1) Begin the Transaction
2) Process database commands
3) Check for errors.
if errors occured, rollback the transaction
else, commit the transaction

Note:- Not able to see the un-committed changes

SET Transaction ISOLATION LEVEL READ UNCOMMITTED

*/


create table tblProduct
(
productid int primary key,
product_name varchar(12),
unitprice int,
qtyavailable int)

insert into tblProduct values(1,'Laptops',2340,100)
insert into tblProduct values(2,'Desktops',3467,20)

select * from tblProduct 

---- Normal Update----
update tblProduct
set qtyavailable=200
where productid=1

--- Update as a part of the Transaction---
Begin Transaction
update tblProduct
set qtyavailable=300
where productid=1

/*
Since you have started a transaction and have not either committed the
transaction or rolled the data back the data will not be visible
in other sql server windows as the default isolation
level of SQL Server is Read Committed that means read only committed
data*/

/*
To read the uncommitted data in other windows:-

SET transaction ISOLATION LEVEL READ UNCOMMITTED

select * from tblProduct

*/

select * from tblProduct

--- Rollback the Transaction---
Begin Transaction
update tblProduct
set qtyavailable=300
where productid=1

rollback Transaction

/* Once rolleback the changes are undone */

----- Commit Transaction-----

/* Once you commit the transaction the changes are made 
permanent to the database */

Begin Transaction
update tblProduct
set qtyavailable=280
where productid=1

commit transaction 

select * from tblProduct 

------------------------- Entire Transaction Example -------------------------

create table tblPhysicalAddress
(addressid int primary key,
 employeenumber int,
 housenumber varchar(5),
 streetaddress varchar(15),
 city varchar(15),
 postalcode varchar(15))

 insert into tblPhysicalAddress values(1,101,'#10','King Street','LONDOON','CR27DW')


 create table tblMailingAddress
(addressid int primary key,
 employeenumber int,
 housenumber varchar(5),
 streetaddress varchar(15),
 city varchar(15),
 postalcode varchar(15))

insert into tblMailingAddress values(1,101,'#10','King Street','LONDOON','CR27DW')

select * from tblPhysicalAddress
select * from tblMailingAddress


---- Write a Transaction code to update the city in both the above tables ----

alter procedure usp_updateAddress
as
begin
begin try
begin transaction
update tblPhysicalAddress set city='LONDON' where addressid=1 and employeenumber=101
update tblMailingAddress set city='LONDON' where addressid=1 and employeenumber=101
commit transaction
Print 'Transaction Committed'
end try
begin catch
rollback transaction
Print 'Transaction Rolledback'
end catch
end


exec usp_updateAddress

/* Since the update statements were correct ti executed successfully and 
committed without any issues.
Now, Lets try to introduce some error
*/


---- Transaction with error to introduce rollback mechanism ---------------

alter procedure usp_updateAddress
as
begin
begin try
begin transaction
update tblPhysicalAddress set city='LONDON1' where addressid=1 and employeenumber=101
update tblMailingAddress set city='LONDON LONDOn LONDON LONDON' where addressid=1 and employeenumber=101
commit transaction
Print 'Transaction Committed'
end try
begin catch
rollback transaction
Print 'Transaction Rolledback'
end catch
end

exec usp_updateAddress

/* 

(1 row affected)

(0 rows affected)
Transaction Rolledback

Completion time: 2024-09-23T22:18:27.9794162-04:00
*/

--- No change when checked the data(Rollback Transaction)----
select * from tblPhysicalAddress
select * from tblMailingAddress


/*
Both the update statements must execute successfully as 
transaction is a single unit and if one of them fails
the entire transaction is rolledback maintaining
the integrity of the database
*/


