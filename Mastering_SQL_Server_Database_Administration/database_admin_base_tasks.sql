/* 

.mdf:- master data file
.ldf:- log data file
.ndf:- new data file

After creating any database 2 files gets created:-
.mdf:- master data file (8 MB)
.ldf:- log data file  (8 MB)


after creating many files as the data increases inside the database, a

.ndf:- new data file is created//

to shrink a database and check the available space:-

right click on the database-> tasks->shrink->files

here, you can check the availble free space in the individual
files in a database//

to check the log files space availability:-
DBCC SQLPERF('LOGSPACE')

but we dont have a similar script available for master database 
so we need to check the scripts on google for the same//

*/

-- Database files and sizes---
SELECT * FROM sys.master_files
SELECT * FROM sys.database_files

-- Database properties
select * from sys.databases 

-- Active sessions
SELECT * FROM sys.dm_exec_sessions where status='running'

-- Connection details
SELECT * FROM sys.dm_exec_connections

-- Requests currently executing
SELECT * FROM sys.dm_exec_requests

-- Query stats
SELECT * FROM sys.dm_exec_query_stats

-- Execution plan cache
SELECT * FROM sys.dm_exec_cached_plans

-- Wait statistics
SELECT * FROM sys.dm_os_wait_stats


-- Server logins
SELECT * FROM sys.server_principals

-- Server permissions
SELECT * FROM sys.server_permissions

-- Linked servers
SELECT * FROM sys.servers

-- Find blocking
SELECT 
    blocked.session_id AS blocked_session,
    blocking.session_id AS blocking_session,
    blocked.wait_time /1000.0 AS wait_time_seconds,
    blocked.wait_type,
    blocked.last_wait_type
FROM sys.dm_exec_requests blocked
JOIN sys.dm_exec_requests blocking 
    ON blocking.session_id = blocked.blocking_session_id;


-- Most expensive queries
SELECT TOP 10
    qs.total_worker_time/qs.execution_count AS avg_cpu_time,
    qs.execution_count,
    SUBSTRING(qt.text,qs.statement_start_offset/2, 
        (CASE 
            WHEN qs.statement_end_offset = -1 
            THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2 
            ELSE qs.statement_end_offset
        END - qs.statement_start_offset)/2) AS query_text
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
ORDER BY avg_cpu_time DESC;

-- Database size info
SELECT 
    DB_NAME(database_id) AS DatabaseName,
    CAST(SUM(size) * 8. / 1024 AS DECIMAL(10,2)) AS DatabaseSizeInMB
FROM sys.master_files
GROUP BY database_id
ORDER BY DatabaseSizeInMB DESC;

-- Tables and indexes---

select * from sys.tables
select * from sys.indexes
select * from sys.index_columns
select * from sys.partitions

-- Check database backup status
SELECT 
    d.name,
    MAX(b.backup_finish_date) as last_backup
FROM sys.databases d
LEFT JOIN msdb.dbo.backupset b 
    ON b.database_name = d.name
GROUP BY d.name


-- Check index fragmentation
SELECT 
    OBJECT_NAME(ips.object_id) AS TableName,
    i.name AS IndexName,
    ips.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) ips
JOIN sys.indexes i ON ips.object_id = i.object_id 
    AND ips.index_id = i.index_id
WHERE ips.avg_fragmentation_in_percent > 30;


-- Database Consistency
DBCC CHECKDB         -- Check database integrity
DBCC CHECKTABLE      -- Check table/view integrity
DBCC CHECKFILEGROUP  -- Check filegroup integrity
DBCC CHECKCATALOG   -- Check catalog consistency


-- Cache Management
DBCC DROPCLEANBUFFERS -- Clear buffer cache
DBCC FREEPROCCACHE    -- Clear procedure cache
DBCC FREESYSTEMCACHE  -- Clear system cache
DBCC FLUSHFILEBUFERS  -- Write dirty buffers to disk

-- Statistics
DBCC SHOW_STATISTICS   -- View statistics info
DBCC UPDATEUSAGE      -- Fix page/row count inaccuracies

-- Informational
DBCC SQLPERF('logspace')  -- Log space usage
DBCC OPENTRAN         -- View open transactions
DBCC INPUTBUFFER      -- Last command sent by session
DBCC OUTPUTBUFFER     -- Output buffer for session

-- System Databases
/*master    -- Server-wide configuration
model     -- Template for new databases
msdb      -- Jobs, backups, alerts
tempdb    -- Temporary objects
resource  -- System objects (hidden)*/


-- Common System Tables in msdb
/*msdb.dbo.backupset        -- Backup history
msdb.dbo.backupmediafamily
msdb.dbo.restorehistory
msdb.dbo.suspect_pages    -- Corrupt pages log
msdb.dbo.sysjobs         -- SQL Agent jobs
msdb.dbo.sysjobhistory*/


-- Metadata Functions
select OBJECT_ID('emp')
select OBJECT_NAME(OBJECT_ID('emp'))

DECLARE @objID INT = OBJECT_ID('dbo.emp');
SELECT OBJECT_NAME(@objID);

SELECT DB_NAME(DB_ID('mastering_sql_server'));

---------- Common DBCC Diagnostic Queries  --------------------

-- Check Database Integrity with Details
DBCC CHECKDB ('mastering_sql_server') WITH ALL_ERRORMSGS, EXTENDED_LOGICAL_CHECKS;

-- Check Specific Table
DBCC CHECKTABLE ('dbo.emp') WITH ALL_ERRORMSGS;

-- View Used Space
DBCC SHOWCONTIG ('emp') WITH TABLERESULTS;

-- Memory Statistics
DBCC MEMORYSTATUS;

-- Show Transaction Log Space
DBCC SQLPERF(LOGSPACE);

-- Clean Buffer Cache and Procedure Cache
DBCC DROPCLEANBUFFERS;
DBCC FREEPROCCACHE;

-- Common System Procedures---

sp_help              -- Object info
sp_helpdb            -- Database info
sp_spaceused        -- Space usage
sp_who              -- Current users
sp_who2             -- Detailed user info
sp_lock             -- Lock info


-- Configuration
sp_configure         -- Server configuration
sp_serveroption     -- Server options
sp_dboption         -- Database options

-- Security
sp_helplogins       -- Login info
sp_helpuser         -- User info
sp_helprole         -- Role info











