--------------------------- DateTime Functions--------------------------------

/* DateTime
  UTC stands for Coordinated Universal Time based on which the world regulates
  clocks and time. THere are slight differences between GMT and UTCbut for the 
  most common purposes UTC is synonymous with GMT
  
 1) getdate():- commonly used
 2) current_timestamp():- ansi sql equivalent to getdate()
 3) sysdatetime():- more fractional seconds precision
 4) sysdatetimeoutoffset():- more fractional seconds precision+ timezone offset
 5) getutcdatereturns utc date and time
 6) sysutcdatetime():- utc date and time with more fractional seconds precision 
  */

  select getdate()

  select isdate('Rohit');--- returns 0
  select isdate(getdate())---- returns 1
  select isdate('2012-08-31 21:02:04.167')--- returns 1
  select isdate('2012-09-01 11:34:21.1918447')--- returns 0


--- Examples----

select day(getdate())--- Returns the current date day number of month
select day('01/31/2012')---- Returns 31

--- Examples-----

select month(getdate())-- returns the current date, month number of year
select month('01/31/2012')--- Returns 1

--- Examples-----

select year(getdate())--- returns the current date the year number
select year('01/31/2012')--- returns 2012

------ DateName()---------------

/*
DateName(DatePart,Date):- returns a string that represents a part of the given
                          date. This function takes 2 parameters. The first
						  parameter datepart specifies the part of the date
						  we want. The second parameter is the actual date 
						  from which we want the part of the date.

*/

select DATENAME(day,'2012-09-30 12:43:46.837')---- Returns 30
select datename(weekday,'2012-09-30 12:43:46.837')--- Returns Sunday
select datename(MONTH,'2012-09-30 12:43:46.837')----- Returns September

select * from tblEmployee001;

select nname,dateofbirth,
       DATENAME(WEEKDAY,dateofbirth) as [day],
	   month(dateofbirth) as MonthNumber,
	   DATENAME(month,dateofbirth) as [MonthName],
	   year(dateofbirth) as [Year]
from tblEmployee001;













