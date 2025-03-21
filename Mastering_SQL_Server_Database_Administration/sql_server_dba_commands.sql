-- Database size info
SELECT 
      database_name = DB_NAME(database_id)
    , log_size_mb = CAST(SUM(CASE WHEN type_desc = 'LOG' THEN size END) * 8. / 1024 AS DECIMAL(8,2))
    , row_size_mb = CAST(SUM(CASE WHEN type_desc = 'ROWS' THEN size END) * 8. / 1024 AS DECIMAL(8,2))
    , total_size_mb = CAST(SUM(size) * 8. / 1024 AS DECIMAL(8,2))
	, total_size_gb = CAST(SUM(size) * 8. / 1024/1024 AS DECIMAL(8,2))
FROM sys.master_files WITH(NOWAIT)
WHERE database_id = DB_ID() -- for current db 
GROUP BY database_id


----- for actual data consumption on disk------

SELECT DISTINCT 
    volume_mount_point AS Drive,
    total_bytes/1024/1024/1024 AS TotalGB,
    available_bytes/1024/1024/1024 AS FreeGB,
    (total_bytes - available_bytes)/1024/1024/1024 AS UsedGB,
    CAST(100 * (CAST(available_bytes AS FLOAT)/ CAST(total_bytes AS FLOAT)) AS DECIMAL(5,2)) AS FreePercent
FROM sys.master_files AS f
CROSS APPLY sys.dm_os_volume_stats(f.database_id, f.file_id);



-- Check database file locations and sizes on C drive
SELECT 
    DB_NAME(database_id) AS DatabaseName,
    name AS FileName,
    type_desc AS FileType,
    physical_name AS FilePath,
    CAST(size * 8. / 1024/1024 AS DECIMAL(10,2)) AS FileSizeGB,
    CAST(CASE 
        WHEN max_size = -1 THEN -1 
        ELSE max_size * 8. / 1024/1024 
    END AS DECIMAL(10,2)) AS MaxSizeGB,
    CASE 
        WHEN is_percent_growth = 1 THEN CAST(growth AS VARCHAR) + '%'
        ELSE CAST(CAST(growth * 8. / 1024 AS DECIMAL(10,2)) AS VARCHAR) + ' MB'
    END AS GrowthSetting
FROM sys.master_files
WHERE physical_name LIKE 'C:\%'
ORDER BY FileSizeGB DESC;




sp_spaceused        -- Space usage
sp_who              -- Current users
sp_who2             -- Detailed user info
sp_helplogins       -- Login info
sp_helpuser         -- User info
sp_helprole         -- Role info

