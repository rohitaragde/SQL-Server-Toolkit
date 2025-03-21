----------------------------- Clustered and NonClustered Indexes---------------------------

/* Clustered Index:- A clustered index determines the physical order of data in a table.
                     For this reason, a table can have only one clustered index.

A clustered index is analogous to a telephone directory where the data is arranged by the
last name. We just learnt that, A table can have only one clustered index. However,
the index can contain multiple columns ( a composite index), like the way a telephone
directory is organized by last name and first name.
*/

create table tblEmployee10
(id int primary key,
 nname nvarchar(20),
 salary int,
 gender nvarchar(10),
 city nvarchar(50));

/*Note:- Id column is marked a primary key. Primary key constriant creates clustered indexes
        automatically if no clustered index already exists on the table.
*/

exec sp_helpindex tblEmployee10

insert into tblEmployee10 values(3,'John',4500,'Male','New York')
insert into tblEmployee10 values(1,'Sam',2500,'Male','London')
insert into tblEmployee10 values(4,'Sara',5500,'Female','Tokyo')
insert into tblEmployee10 values(5,'Todd',3100,'Male','Toronto')
insert into tblEmployee10  values(2,'Pam',6500,'Female','Sydney')

select * from tblEmployee10

/* Create a composite clustered index on the Gender and Salary columns*/

create clustered index IX_tblEmployee_Gender_Salary
on tblEmployee10(gender desc, salary asc)

/* We can see that the data is arranged in the order of gender first and then
 the salary and thats called composite clustered index.

 Also, you cannot drop a primary key clustered index explicitly so for such case
 drop the clustered index using the GUI:-
 Go to Table->Indexes->IndexName->Rt click and delete it it will get deleted safely.
 */

 /*
 Non- CLustered Indexes

a) A non clustered index is analogous to a textbook. The data is stored in one place,
   the index in another place.The index will have pointers to the storage location
   of the data.

b) Since, the non clustered index is stored seperately from the actual data , a table
   can have more than one non clustered index, just like how a book can have an index
   by chapters at the beginning and another index by common terms at the end.

c) In the index itself, the data is stored in the assending or descending order of the
   index key, which does'nt in any way influence the storage or data in the table.
*/

create nonclustered index IX_tblEmployee_nname
on tblEmployee10(nname)

select * from tblEmployee10
where nname='Pam'

/* Difference between Clustered and NonClustered Index

a) Only One clustered index per table, whereas you can have more than one non-clustered
   index.
b) Clustered index is faster than a non clustered index because the non clustered index
   has to refer back to the table if the selcted column is not present in the index.

c) Clustered index determines the storage order of rows in the table and hence does'nt
   require additional disk space but whereas a non clustered index is stored seperately
   from the table additional storage space is required*/




