------------------------------------ Database Mail ----------------------------------------

/*

Database email allows you to send email messages to users from the SQL Server Database Engine. The email message can be plain text or HTML and may include attach files.

The Database Mail is reliable, scalable, secure, and supportive.

Reliability
Database Mail uses SMTP to send email messages.
SQL Server uses a separate process to deliver email messages to minimize the performance impact on the server. 
SQL Server will queue the email messages even if the SMTP server is offline. The email message will be sent when the
SMTP server comes online.Database Mail can use multiple SMTP servers. If an SMTP server is unavailable,
it’ll use the second SMPT server to send email messages.

Scalable
Database Mail sends email messages asynchronously in the background. 
To send an email message, you use the sp_send_dbmail stored procedure. 
This stored procedure adds a request to a Service Broker queue and returns immediately.
The external email component receives the request and delivers the email message.

Security
The Database Mail is off by default. To send email messages, you must enable it first.
The user must be a member of the DatabaseMailUserRole database role in the msdb database to
send an email.
Database Mail allows you to secure the mail profiles.
Database Mail allows you to configure the attached size limit and extension of attached files. 
If you want to attach a file from a folder to an email,
the SQL Server engine account needs to have permission to access the file.

Supportability
Logging – Database Mail logs email activity to tables in the msdb system database and the 
Microsoft Windows application event log.
Auditing – Database Mail keeps copies of email messages and attachments in the msdb database.
Multiple email formats – Database Mail supports both plain text and HTML formats.

*/

------------------------- Configure SQL Server Database Mail -------------------------------

---------------- First, change the Show Advanced configuration setting to 1: -------------------

sp_configure 'Show Advanced', 1;
reconfigure;

/* By doing this, you can view all global configuration settings of the current server
using the sp_configure stored procedure:*/

sp_configure

/* Second, enable the Database Mail for the current SQL Server instance:*/

sp_configure 'Database Mail XPs',1 
reconfigure

/* Third, create a Database Mail account using the msdb.dbo.sysmail_add_account_sp stored procedure:*/

EXECUTE msdb.dbo.sysmail_add_account_sp
@account_name = 'Primary Account',
@description = 'Account used by all mail profiles.',
@email_address = 'ragderohit1997@gmail.com',
@replyto_address = 'ragderohit1997@gmail.com',
@display_name = 'Database Mail',
@mailserver_name = 'smtp.sqlservertutorial.net';

/* Fourth, create a Database Mail profile:*/

EXECUTE msdb.dbo.sysmail_add_profile_sp
@profile_name = 'Public Profile',
@description = 'public profile for all users';

/* Fifth, add the account to the Public Profile:*/

EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
@profile_name = 'Public Profile',
@account_name = 'Primary Account',
@sequence_number = 1;

/* Sixth, grant access to the profile to all msdb database users:*/

EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
@profile_name = 'public Profile',
@principal_name = 'public',
@is_default = 1;

----------------------------- Send email using Database Mail ------------------------------

/* To send an email message, you use the msdb.dbo.sp_send_dbmail stored procedure.*/

----------------------------- Sending an email message example ----------------------------

/* The following example sends an email message to the email address ragderohit2024@gmail.com:*/

EXEC msdb.dbo.sp_send_dbmail  
    @recipients = 'ragderohit2024@gmail.com',  
    @body = 'This is a test message',  
    @subject = 'Database Mail Test';

/* Sending an email message with the result of a query example */

/* First, select the inventory for the products id 1 and 2: */

SELECT
  store_name,
  product_name,
  SUM(quantity)
FROM sales.stores s
INNER JOIN production.stocks i
  ON i.store_id = s.store_id
INNER JOIN production.products p
  ON p.product_id = i.product_id
WHERE p.product_id IN (1, 2)
GROUP BY store_name,
         product_name;


--------- Second, convert the query result into an HTML table body. Each row in the result set is an HTML table row with the <tr> tag:----------------

SELECT
  CAST((SELECT
    td = store_name,
    '',
    td = product_name,
    '',
    td = SUM(quantity),
    ''
  FROM sales.stores s
  INNER JOIN production.stocks i
    ON i.store_id = s.store_id
  INNER JOIN production.products p
    ON p.product_id = i.product_id
  WHERE p.product_id IN (1, 2)
  GROUP BY store_name,
           product_name
  FOR xml PATH ('tr'), TYPE)
  AS nvarchar(max));


  -------------------  Third, convert the HTML table body into text:---------------------

  DECLARE @tableHTML NVARCHAR(MAX);  
  
SET @tableHTML =  
    N'<h1>Inventory Report</h1>' +  
    N'<table border="1">' +  
    N'<tr><thead><th>Store Name</th><th>Product</th><th>Total Quantity</th></thead><tbody>' +  
    CAST ( (  
			SELECT
			  td=store_name,'',
			  td=product_name,'',
			  td=SUM(quantity),''
			FROM sales.stores s
			INNER JOIN production.stocks i
			  ON i.store_id = s.store_id
			INNER JOIN production.products p
			  ON p.product_id = i.product_id
			WHERE p.product_id IN (1, 2)
			GROUP BY store_name,
					 product_name
			FOR XML PATH('tr'), TYPE 
	) AS NVARCHAR(MAX) ) +  
    N'</tbody></table>' ;  

SELECT @tableHTML;

---------------- Finally, send an email message to the email ragderohit2024@gmail.com:-------------------

EXEC msdb.dbo.sp_send_dbmail 
    @recipients='ragderohit2024@gmail.com',  
    @subject = 'Inventory List',  
    @body = @tableHTML,  
    @body_format = 'HTML';  
