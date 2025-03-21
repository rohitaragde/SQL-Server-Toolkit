USE [TUT]
GO

/****** Object:  StoredProcedure [dbo].[spGetEmployees]    Script Date: 24/05/2024 21:44:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[spGetEmployees]
@TotalCount int output
with encryption
AS
BEGIN
	  select @TotalCount=count(id) from tblEmployee
END
GO

 

Declare @TotalEmployees int
exec spGetEmployees @TotalEmployees out
select @TotalEmployees