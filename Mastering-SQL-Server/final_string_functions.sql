-------------------------- More Additional String Functions------------------------

---- Replicate() function------

/*replicate(string_to_be_replicated,no_of_times_to_replicate)
Repeats the given string for the specified number of times.*/

select replicate('Rohit ',3)

create table tblEmployee01
(firstname varchar(10),
 lastname varchar(10),
 email varchar(30));

 select * from tblEmployee01;

select  firstname,lastname,
substring(email,1,2) + replicate('*',5) 
+ substring(email,charindex('@',email),len(email)-charindex('@',email)+1) as email
from tblEmployee01

------- Space() Function ----------------

/* space(number of spaces) returns the number of spaces
specified by the number_of_spaces argument*/

select firstname + space(7) + lastname as fullname
from tblEmployee01;

------- PatiIndex() Function-----------------------
/*
PATINDEX('%Pattern%',Expression)
it returns the starting position of the first occurence of a pattern in a
specified expression. it takes two arguments, the pattern to be searched
and the expression. PATINDEX() is similar to CHARINDEX(). with CHARINDEX()
we cannot use wildcards, whereas PATINDEX() provides this capability. If
the specified pattern is not found, PATINDEX() returns 0.
*/

select email,
PATINDEX('%@aaa.com',email) as firstoccurence
from tblEmployee01
where PATINDEX('%@aaa.com',email)>0; 

/* Replace() Function
Replace(String Expression,pattern,replacement_value)
it replaces all occurences of a specified string value
with another string value
*/

select email,replace(email,'.com','.net') as convertedEmail
from tblEmployee01;

/* STUFF() Function
STUFF(original_expression,start_length,replacement_expression)
stuff() function inserts replacement expresssion at the start
position specified along with removing the characters 
specified using length parameter.*/


select firstname,lastname,email,
stuff(email,2,3,'*****') as StuffedEmail
from tblEmployee01;











