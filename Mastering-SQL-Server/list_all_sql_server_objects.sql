--------------- List All tables in a SQL Server DB using a Query ----------------

/*

Object Explorer within the SQL Server Management Studio can be used to get
the list of tables in a specific database. However, if we have to write a
query to achieve the same, there are 3 system views that we can use:-

a) SYSOBJECTS:- SQL Server 2000,2005 and 2008
b) SYS.TABLES:- SQL Server 2005 and 2008
c) INFORMATION_SCHEMA.TABLES:- SQL Server 2005 and 2008

*/

--- Gets the list of tables only ----

select * from sysobjects where xtype='V'

--- Gets the list of tables only---

select * from sys.tables 

--- Gets the list of views only---

select * from sys.views  

--- Gets the list of procedures only---

select * from sys.procedures  

--- Gets the list of tables,views and stored procedures and Functions ---

select * from INFORMATION_SCHEMA.TABLES

select * from INFORMATION_SCHEMA.VIEWS 

select * from INFORMATION_SCHEMA.ROUTINES where ROUTINE_TYPE='Procedure'

select * from INFORMATION_SCHEMA.ROUTINES where ROUTINE_TYPE='Function'

--- To get the list of different object types(XTYPE) in a database ----

select distinct xtype from sysobjects 

/*
IT- Internal Table
P- Stored Procedure
PK- Primary Key Constraint
S- System Table
U- User Table
v-View
*/


