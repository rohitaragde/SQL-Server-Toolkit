----------------------------------Phantom Read -----------------------------------------------

---- Phantom Read happens when one transaction executes twice and it gets a different no of
---- rows in the resultset each time-----

--- This happens when a second transaction inserts a row that matches the where clause of the query
--- executed by the first transaction ---

	
select * from tblEmployee;

-------------- Transaction 01 ------------------------


Begin Transaction
select * from tblEmployee where id between 1 and 3


waitfor delay '00:00:10'

select * from tblEmployee where id between 1 and 3

commit Transaction






