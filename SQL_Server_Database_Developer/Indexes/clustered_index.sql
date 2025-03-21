--------------------Indexes---------------------------------

-- A table can have only one clustered index
--- A clustered index determines the order in which the 
-- data gets stored
--- We can have a composite clustered index using multiple
---columns

select * from tblEmployee;

Create Index IX_tblemployee_Salary 
ON tblEmployee(Salary Asc)

sp_Helpindex tblEmployee_11

drop index tblEmployee_11.PK__tblEmplo__3213E83FD31892C7


select * from tblEmployee_11

create clustered index IX_tblEmployee_Gender_Salary
on tblEmployee_11( Gender desc, salary asc)








