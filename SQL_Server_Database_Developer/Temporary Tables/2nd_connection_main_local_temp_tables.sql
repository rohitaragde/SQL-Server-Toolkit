------------------------2nd connection---------------------------

 select name from tempdb..sysobjects
 where name like '#personDetails%'

 select * from #PersonDetails

 ---------- Local temporary table only available for connection that created it---
 --------- it is dropped once the connection that created it is closed----------------
 ------- we can volantarily drop the local temp table by using drop table @tablename it will
 ------- be automatically dropped.-----------

 ---------- if you create a local temp table as a part of a stored procedure it gets dropped
 ------- automatically after the completion of the stored procedure----------------

 create procedure spCreateLocalTempTable
 as
 begin
	  create table #PersonDetails(id int,name nvarchar(20))
	  insert into #PersonDetails values(1,'Mike')
	  insert into #PersonDetails values(2,'John')
	  insert into #PersonDetails values(3,'Todd')

select * from #PersonDetails
 end


 exec spCreateLocalTempTable

 
select * from #PersonDetails