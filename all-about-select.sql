---------------------- All About Select -------------------------------------


---- Selecting specific or all columns---------

select * from tblPerson

select id,nname,email,genderid,age
from [TUT].[dbo].[tblPerson]

------- Distinct Rows -----------------------

select distinct city from tblPerson

-- applies distinct to both the columns-----

select distinct nname,city from tblPerson

----------- Filtering Rows---------------------

select * from tblPerson where city='London'

-- not equal to London---
select * from tblPerson where city<>'London'

select * from tblPerson where city!='London'

--- Usage of In Operator----

select * from tblPerson where age=20 or age=23 or age=29

select * from tblPerson where age in(20,23,29);

---- Usage of Between operator---
--- boundary values are inclusive ---

select * from tblPerson where age>=20 and age<=25;

select * from tblperson where age between 20 and 25;

---- Usage of Like Operator ---
/*
%- 0 or more characters ( can be anything after the mentioned character)
_- signifies exactly one character
[]- signifies any character within the brackets
[^]- not any character within the brakcets*/

select * from tblPerson where city like 'L%';

select * from tblPerson where email like '%@%';

select * from tblPerson where email like '_@_.com';

select * from tblPerson where email not like '%@%';

--- Indicates starts with specific list of characters---

select * from tblPerson where nname like '[NH]%'
select * from tblPerson where nname like '[^NH]%'

---- Combining And and OR conditions----------------------------

select * from tblPerson where (city='London' or city='Mumbai') and age>=25;

select * from tblPerson where city in('London','Mumbai') and age>=25;

---- Sorting Results using the Order By Clause ------------------

select * from tblPerson order by nname;

select * from tblPerson order by nname desc;

select * from tblPerson order by nname desc,age;

--- Selecting Top N / Top percentage of rows -------------------------

/*
 when you do top n* you get that many records 
 for 1*- 1 row 2* 2 rows likewise
 
 when you do top n columnames- top n records for those columns

 when you do top 50 percent * - 50 percentage of total no of records
 will be displayed*/

select top 2 nname,age from tblPerson;

select top 1 percent * from tblPerson;

select top 50 percent * from tblPerson;

select top 2 nname,age from tblPerson;

select top 4* from tblPerson;

---- Eldest person in the tblperson table----

select top 1* from tblPerson order by age desc;















