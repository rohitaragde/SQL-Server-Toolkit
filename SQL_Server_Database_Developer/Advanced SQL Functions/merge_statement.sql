------------------------------ Merge Statement -------------------------------------

-- it allows inserts, updates and deletes in one statement
-- Source Table :- Contains the changes that needs to be applied to the target table
-- Target Table :- The table that requires changes

truncate table StudentSource;
truncate table StudentTarget;

insert into StudentSource values(1,'Mike');
insert into StudentSource values(2,'Sara');

insert into StudentTarget values(1,'Mike M');
insert into StudentTarget values(3,'John');


select * from StudentSource;
select * from StudentTarget;

merge into StudentTarget as T
using StudentSource as S
on T.ID=S.ID
when matched then 
update set T.NAME=S.NAME
WHEN NOT MATCHED BY TARGET THEN
INSERT(ID,NAME) VALUES(S.ID,S.NAME);
--WHEN NOT MATCHED BY SOURCE THEN
--DELETE;


