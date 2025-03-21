-------------------------------- Indexes-----------------------------------------

/*
Indexes are used by queries to find data from tables quickly. Indexes are created on
tables and views.Index on a table or view is very similar to the index that we find
in our book.

If you dont have an index and I ask you to locate a specific chapter in the book,
you will have to look at every page staritng from the first page of the book.On
the other hand, if you have the index you can lookup the pagenumber of the chapter
in the index,and then directly go to the page number to locate the chapter.

Obviously, the book index is helping drastically to reduce the time it takes to find
the chapter.In the similar way, Table and View indexes can help the query to find 
the data quickly.

Infact, the existence of the right indexes can drastically improve the performance
of the query.If there is no index to help the query then the query engine checks
every row in the table from the beginning to the end. This is called as Table Scan.
Table Scan is bad for performance.*/

---- Emp Table without an index causing full table scan ----

select * from emp001
where salary>5000 and salary<7000 

--- Creating an Index----


create index IX_tblEmp001_Salary
on emp001(salary asc)

/*
The index stores salary of each employee in the ascending order.
The actual index may look differnet. Note that index acts as a pointer
so it stores the memory address to the location to the actual data*/

-- To query the index through query (using system stored procedure sp_helpindex)-----

sp_helpindex emp001

-------To drop an index-------------

drop index emp001.IX_tblEmp001_Salary






















