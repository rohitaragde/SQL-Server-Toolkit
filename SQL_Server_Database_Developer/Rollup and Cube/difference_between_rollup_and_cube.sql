---------------------Difference between rollup and cube-----------------

create table sales69
(continent varchar(10),
country varchar(20),
city varchar(10),
saleamount varchar(10));


select * from sales69;

select continent,country,city,sum(saleamount) as totalsales
from sales69
group by rollup(continent,country,city)

SELECT continent, country, city, SUM(CAST(saleamount AS DECIMAL)) AS totalsales
FROM sales69
GROUP BY cube(continent, country, city);

SELECT continent,SUM(CAST(saleamount AS DECIMAL)) AS totalsales
FROM sales69
GROUP BY cube(continent);

SELECT continent,SUM(CAST(saleamount AS DECIMAL)) AS totalsales
FROM sales69
GROUP BY rollup(continent);


