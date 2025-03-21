-------------------------------2nd Connection------------------------------

create table #PersonDetails
(id int,
 name nvarchar(20))

 insert into #PersonDetails values(1,'Mike')
 insert into #PersonDetails values(2,'John')
 insert into #PersonDetails values(3,'Todd')

 select * from #PersonDetails