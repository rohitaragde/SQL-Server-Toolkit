WITH cte AS (
    SELECT *,
        ROW_NUMBER() OVER (ORDER BY hall_id, start_date) AS event_id
    FROM hall_events
),
r_cte AS (
    SELECT hall_id, start_date, end_date, 1 AS flag, event_id
    FROM cte
    WHERE event_id = 1
    UNION ALL
    SELECT cte.hall_id, cte.start_date, cte.end_date, 
        CASE 
            WHEN cte.hall_id = r_cte.hall_id 
            AND (cte.start_date BETWEEN r_cte.start_date AND r_cte.end_date 
                 OR cte.start_date BETWEEN cte.start_date AND cte.end_date) 
            THEN 0 
            ELSE 1 
        END + r_cte.flag AS flag, 
        cte.event_id
    FROM r_cte
    INNER JOIN cte ON r_cte.event_id + 1 = cte.event_id
)
SELECT hall_id,flag,
min(start_date) as start_date,
max(end_date) as end_date
FROM r_cte
group by hall_id,flag

