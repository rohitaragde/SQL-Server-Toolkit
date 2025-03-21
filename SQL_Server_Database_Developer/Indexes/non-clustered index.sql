------------------------------Non-Clustered Index--------------------------
--- analogous to the book 
-- index is at a different place than the actual table
--- acts as a index to the storage location of the data
--- since stored seperately from the table hence we can have 
--- mre than one non clustered index

create non clustered index IX_tblEmployee_Name
on tblEmployee_11(Name)


