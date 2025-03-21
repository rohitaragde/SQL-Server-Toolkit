USE [TUT]
GO

/****** Object:  StoredProcedure [dbo].[spGetEmployees]    Script Date: 24/05/2024 21:44:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[spGetEmployees]
@Id int,
@Name nvarchar(20) output
with encryption
AS
BEGIN
	  select @Name=Name from tblEmployee where Id=@Id  
END
GO

select * from tblEmployee

 declare @EName nvarchar(20)
 exec [spGetEmployees] 4, @EName out
 select @EName

