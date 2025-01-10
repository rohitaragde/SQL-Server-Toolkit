------------------------ Import Date Functions--------------------------

/*

Datepart(datepart,date):- returns an integer representing the specified
                          datepart. this function is similar to datename().
						  DateName() returns nvarchar whereas datepart()
						  returns ineger.

dateadd(datepart,numbertoadd,date):- returns the datetime, after adding
                                     specified numbertoadd to the datepart
									 specified of the given date.

datediff(datepart,startdate,enddate):- returns the count of the specified
                                       datepart boundaries crossed between
									   the specified startdate and enddate.
*/

select datepart(weekday,'2012-08-30 19:45:31.793')--- returns 5
select datename(weekday,'2012-08-30 19:45:31.793')---- returns Thursday

select dateadd(day,20,'2012-08-30 19:45:31.793')--- returns 2012-09-19 19:45:31.793
select dateadd(day,-20,'2012-08-30 19:45:31.793')-- returns 2012-08-10 19:45:31.793

select datediff(MONTH,'11/30/2005','01/31/2006')-- returns 2
select datediff(day,'11/30/2005','01/31/2006')--- returns 62

select * from tblEmployee001



