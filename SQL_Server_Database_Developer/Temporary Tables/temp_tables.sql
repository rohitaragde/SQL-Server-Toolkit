----------------------------------- Temp Tables------------------------------------------
--------------1st connection--------------------------
---- similar to permanent tables but permanent tables gets created in the database you specify
--- and remain in the database permanently until you drop them
---- whereas temp tables gets created in the TempDB and ae automatically deleted when they are
---- no longer used


----Types of temporary tables
---- Local Temp Tables
---- Global Temp Tables

---- single hash means local temporary table and
---- it is only available for the connection that created it


create table PersonDetails
(id int,
 name nvarchar(20))

 insert into #PersonDetails values(1,'Mike')
 insert into #PersonDetails values(2,'John')
 insert into #PersonDetails values(3,'Todd')

 select * from #PersonDetails

 select name from tempdb..sysobjects
 where name like '#personDetails%'



