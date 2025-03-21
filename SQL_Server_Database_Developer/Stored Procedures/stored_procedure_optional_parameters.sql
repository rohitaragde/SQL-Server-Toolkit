----------------------- Stored Procedure Optional Parameters ---------------------------------

-- select * from tblEmployee;

-- By specifying the defualt values we can make the stored procedure parameters optional

alter proc spSearchEmployees
@Name nvarchar(50)=NULL,
@Email nvarchar(50)=NULL,
@Gender nvarchar(50)=NULL,
@Age int=NULL
as 
Begin
select * from tblEmployeeF
  where (name=@Name or @Name is null)
      and(gender=@Gender or @Gender is null)
	  and (Email=@Email or @Email is null)
	  and (Age=@Age or @Age is null)
End


exec spSearchEmployees @Gender='male', @Age=29