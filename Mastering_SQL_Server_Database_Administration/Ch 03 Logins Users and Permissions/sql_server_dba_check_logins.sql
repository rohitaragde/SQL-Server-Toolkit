


--- to check the login property:-
/*

1- Windows only
0- Windows and SQL Server

to enable rt click connection-properties-security-enable windows and sql server login
Restart the SQL Server service by:_
windows+R-services.msc- restart the sql server instance
*/

SELECT SERVERPROPERTY('IsIntegratedSecurityOnly') AS [IsWindowsAuthOnly];
