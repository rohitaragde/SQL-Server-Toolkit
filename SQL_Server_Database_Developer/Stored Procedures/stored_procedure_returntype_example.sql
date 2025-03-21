USE [TUT]
GO

/****** Object:  StoredProcedure [dbo].[spGetEmployees]    Script Date: 24/05/2024 21:44:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[spGetEmployees]
with encryption
AS
BEGIN
	return(select count(id) from tblEmployee) 
END
GO



Declare @TotalEmployees int
exec @TotalEmployees= [spGetEmployees]
select @TotalEmployees