----------------------Global Temporary Tables----------------------------------


--- It is created with 2 hashes instead of 1 hash in Global Temporary Tables
--- It can be accessed in anoy of the concurrent connections
--- It is only destroyed once the last connection referencing the temp table is closed
--- Multiple users across multiple connections can have local temporary tables with the same name
---- but the global temporary tables has to be unique-----------

create table ##EmployeeDetails
(id int,
 name nvarchar(20))

 insert into ##EmployeeDetails values(1,'Mike')
 insert into ##EmployeeDetails values(2,'John')
 insert into ##EmployeeDetails values(3,'Todd')

 select * from ##EmployeeDetails


 --------------- Difference between LTT and GTT------------------------

 -- 1) LTT prefixed with single # whereas GTT prefixed with ##
 -- 2) at the end pf LTT SQL Server prefix some random numbers but it does not happen with GTT
 ---3) LTT only visible to the session where its created whereas GTT is visisble across several connections and users
 --- 4) LTT are automatically dropped when the session is closed whereas GTT is destroyed when the last connection
 ---- referencing the global temp table is closed


