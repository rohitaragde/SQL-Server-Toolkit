------------------------------ Unique Constraint --------------------------------

/* We enforce unique key constraint to enforce uniqueness of a column i.e the column
should'nt allow any duplicate values.

The primary key and unique key both are used to enforce uniqueness of a column.
So when to choose what?

A table can have only one primary key. if you want to enforce uniqueness on 2 or more
columns then we can use unique key constraint

Primary key does not allow nulls whereas unique key constraint allows one null
*/

----------------------- Adding a unique constraint on email column-----------------
select * from tblPerson1;

alter table tblPerson1
add constraint UQ_tblPerson_UEmail unique(email)

------------------- Tring to insert an duplicate email-------------------------

insert into tblPerson1 values('Shivam','kgs@gmail.com');

/*
Msg 2627, Level 14, State 1, Line 21
Violation of UNIQUE KEY constraint 'UQ_tblPerson_UEmail'. Cannot insert duplicate key in object 'dbo.tblPerson1'. The duplicate key value is (kgs@gmail.com).
The statement has been terminated*/

--- Dropping the unique constriant-------------------

alter table tblPerson1
drop constraint UQ_tblPerson_UEmail





