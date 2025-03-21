------------------------------ Identity Column --------------------------------

/* When a column is marked as an identity column then the values 
for this column are automatically generated when you insert a new
row into the table*/

create table tblPerson1
(PersonId int identity(1,1) primary key,
personName nvarchar(50));

/* Default Insertion into the tblPerson1 
  since its an identity column no need to mention the id*/

insert into tblperson1 values('Martin');


select * from tblPerson1;

/* Once you delete a particular id for instance 1 to reuse it,
we have to set the 
set IDENTITY_INSERT tblPerson1 ON and
perform the insertion while mentioning the columnames as well*/

insert into tblPerson1(PersonId,personName) values(1,'Jane');

/* switch off the identity_insert off once the ids are as usual*/

set IDENTITY_INSERT tblPerson1 OFF;


select * from tblPerson1;


/* if you have deleted all the rows in a table and want to reset the 
identity column value use dbcc checkident command*/

delete from tblPerson1;

dbcc checkident(tblPerson1,Reseed,0)

/* once you reset it rests to 0 but since our identity column
while table creation is starting from 1 and increment 1
after first row insertion it stores as 1 and so on*/

insert into tblPerson1 values('Ronit');
insert into tblPerson1 values('Monit');
insert into tblPerson1 values('Keyur');
insert into tblPerson1 values('Vasant');

select * from tblPerson1;
