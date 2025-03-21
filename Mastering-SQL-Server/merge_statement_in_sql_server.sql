----------------------------- Merge in SQL Server --------------------------------

/*

Merge statement allows us to perform inserts,updates and deletes in one statement. This means
we no longer have to use multiple statements for performing insert,update and delete.

with merge statement, we require 2 tables:-
1) Source Table:- Contains the changes that needs to be applied to the target table
2) Target Table:- The table that require changes (inserts,updates and deletes)

Merge statement joins the target table to the source table using a common column in both the 
tables. Based on how the rows match up, we can perform insert,update and delete
on the target table.

*/


create table StudentSource
(
   id int primary key,
   nname varchar(10))

insert into StudentSource values(1,'Mike')
insert into StudentSource values(2,'Sara')

create table StudentTarget
(
  id int primary key,
  nname varchar(20))

insert into StudentTarget values(1,'Mike M')
insert into StudentTarget values(3,'John')

---------------------------- Merge Implementation ----------------------------------

---------------Before Merge Implementation ---------------

select * from StudentSource
select * from StudentTarget

/*

id	nname
1	Mike
2	Sara

id	nname
1	Mike M
3	John

*/

merge into StudentTarget as T
using StudentSource as S
on T.id=S.id 
when matched then 
update set T.nname=s.nname 
when not matched by target then 
insert (id,nname) values(s.id,s.nname)
when not matched by source then 
delete;

/* Merge statement should end with a semicolon and if nto SQL Server will throw an error */



---------------------- After Merge Implementation -------------------------

select * from StudentSource
select * from StudentTarget

/*
StudentSource

id	nname
1	Mike
2	Sara

StudentTarget

id	nname
1	Mike
2	Sara

*/

/*

In real time we mostly perform inserts and updates we dont really delete the data so we can just
omit the last part in the updated merge script 

In the example below, only INSERT and UPDATE is performed. 
We are not deleting the rows that are present in the target table but not in the source table.

*/

Truncate table StudentSource
Truncate table StudentTarget
GO

Insert into StudentSource values (1, 'Mike')
Insert into StudentSource values (2, 'Sara')
GO

Insert into StudentTarget values (1, 'Mike M')
Insert into StudentTarget values (3, 'John')
GO

MERGE INTO StudentTarget AS T
USING StudentSource AS S
ON T.ID = S.ID
WHEN MATCHED THEN
 UPDATE SET T.NNAME = S.NNAME
WHEN NOT MATCHED BY TARGET THEN
 INSERT (ID, NNAME) VALUES(S.ID, S.NNAME);

select * from StudentSource
select * from StudentTarget

/*

id	nname
1	Mike
2	Sara


id	nname
1	Mike
2	Sara
3	John

As ypu can see in this case we updated Mike the record that matched inserted the record
which was not there in target when not matched by target and
lastly we did not had anything when not matched by source as we did not want to delete
the records as the business case for the real time scenario

*/









