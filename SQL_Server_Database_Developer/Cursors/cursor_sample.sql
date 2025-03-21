Declare @ProductId int
Declare @Name nvarchar(30)

Declare ProductCursor CURSOR FOR
select id,name from tblProducts 

Open ProductCursor

Fetch Next from ProductCursor into @ProductId

while(@@FETCH_STATUS=0)
Begin
      print 'Id=' + cast(@ProductId as nvarchar(10)) + 'Name=' + @Name

		Fetch Next from ProductCursor into @ProductId, @Name

End

Close ProductCursor
DEALLOCATE ProductCursor

