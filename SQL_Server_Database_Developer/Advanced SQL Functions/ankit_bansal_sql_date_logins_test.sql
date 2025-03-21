--------------------------------------SQL Test -------------------------------------------------
select * from users001;

select * from logins;

--- today's date: June 05th 2024
--After 5th Feb 2024


--1 Mangement wants to see all the users that did not login in the past 5 months
-- return: username

select *, dateadd(month,-5,getdate()) from logins;

select user_id,max(login_timestamp) 
from logins
group by user_id
having max(login_timestamp)<dateadd(month,-5,getdate());

select distinct user_id
from logins where user_id
not in(select user_id from logins where login_timestamp>dateadd(month,-5,getdate()))


--- 2 For the business units quarterly analysis calculate how many years and how many sessions
-- were at each quarter order by quarter from newest to oldest
--- Return: first day of the quarter, user_cnt, session_cnt

select datetrunc(quarter,min(login_timestamp)) as first_quarter_date,
count(*) as session_cnt,
count(distinct user_id) as user_cnt
from logins
group by datepart(quarter,login_timestamp)

--3 Display user id's that logged in January 2024 and did not login on November 2023
-- Return: user_id
-- 1,2,3,5
-- 7,2,4,6

select distinct user_id from logins
where login_timestamp between '2024-01-01' and '2024-01-31'
and user_id not in (select user_id from logins where login_timestamp between '2023-11-01' and '2023-11-30')



-- 4 Add to the query from to the percentage change in sessions from last quarter.
-- return: first day of the quarter,session_cnt,session_cnt_prev,session_percent_change

with cte as
(
select datetrunc(quarter,min(login_timestamp)) as first_quarter_date,
count(*) as session_cnt,
count(distinct user_id) as user_cnt
from logins
group by datepart(quarter,login_timestamp)
)

select *,
coalesce(lag(session_cnt,1) over(order by first_quarter_date),0) as prev_session_count,
coalesce((session_cnt-lag(session_cnt,1) over(order by first_quarter_date))*100.00/lag(session_cnt,1) over(order by first_quarter_date),0)
from cte;


-- 5 Display the user that had the highest session score(max) for each day-
--- Return: date,username,score

select * from logins;

with cte as(
select user_id,cast(login_timestamp as date) as login_date,
sum(session_score) as score
from logins
group by user_id,cast(login_timestamp as date)
--rder by cast(login_timestamp as date),score 
)

select * from
(
select *,
row_number() over(partition by login_date order by score desc) as rn
from cte) a
where rn=1;


--- 6 To identify our best users - Return the users that had a session on every single day
-- since their first login  ( make assumptions if needed)
--- Return: user_id

select user_id,min(cast(login_timestamp as date)) as first_login,
datediff(day,min(cast(login_timestamp as date)),getdate())+1 as no_of_logins_days_required,
count(distinct cast(login_timestamp as date)) as no_of_login_days
from logins
group by user_id 
having datediff(day,min(cast(login_timestamp as date)),getdate())+1=count(distinct cast(login_timestamp as date))
order by user_id



-- 7 On what dates there were no logins at all?
-- Return: login dates
-- 2023-07-15 and 2024-06-28

with cte as
(
select cast(min(login_timestamp)as date) as first_date,
cast(getdate() as date) as last_date 
from logins 
union all
select dateadd(day,1,first_date) as first_date,last_date from cte 
where first_date<last_date
)
select * from cte
where first_date not in(select distinct cast(login_timestamp as date)  from logins)
option(maxrecursion 500)
