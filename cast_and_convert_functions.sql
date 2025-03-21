------------------------ Cast and Convert Functions------------------------------

/* To convert one datatype to another CAST() and CONVERT()
functions can be used.

Syntax:-

CAST(expression as datatype [(length)])
CONVERT(data_type [(length)],expression [style])

*/

select * from tblEmployee001

select id,nname,dateofbirth ,
cast(dateofbirth as nvarchar(40)) as ConvertedDOB from tblEmployee001

select id,nname,dateofbirth,
convert(nvarchar,dateofbirth,103) as ConvertedDB
from tblEmployee001

---------------- DatePart of DateTime----------------------------------

select convert(varchar(10),getdate(),101); --- Returns 08/15/2024

select cast(getdate() as date)--- Returns 2024-08-15
select convert(date,getdate())---- Returns 2024-08-15

/* To control the formatting of the Date part, DateTime has to be converted to
NVarchar using the styles provided. When converting the date datatype , the
convert() function will ignore the style parameter*/


---- Concatenate id(INT) and Name(NVarchar)

select id,nname + '-'  + cast(id as nvarchar) as [Name-id]
from tblEmployee001


----------------------- Another Practical Example ------------------------------

select * from tblRegistrations

select registereddate as RegisteredDate,
       count(id) as TotalRegistrations
from tblRegistrations
group by RegisteredDate

/* Here we have 3 users registered on 24th, 2 on 25th and 1 on 26th
   but the dates are treated as a seprate groups and the output
   is displayed like 3 rows for 24th with 1 for registration 
   count and similarly for 25th and 26th and it happens simply
   because we dont have same date and time combination to form groups
   and for the same reason we need to convert the registereddate
   column to date*/


select cast(registereddate as date) as RegisteredDate,
        count(id) as TotalRegistrations
from tblRegistrations
group by cast(registereddate as date);

/* Here as you can see above we have used cast to convert
  the datetime to date  and we can now see 
  3 registrations for 24th 2 for 25th and 1 for 26*/

------ Difference between Cast() and Convert()--------------------

/* a) Cast() is based on ANSI standard and convert is specific to
      SQL Server. So, if portability is a concern and you want to
	  use the script with other database applications use cast().

	b) convert() provides more flexibility than cast(). for example,
	   its possible to convert how you want datetime datatypes to be
	   converted using styles and convert function.

The general guideline is to use cast(), unless you want to take advantage
of the style functionality in convert().

*/










