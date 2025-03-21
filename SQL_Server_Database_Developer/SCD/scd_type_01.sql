---- Implementing SCD1 and SCD2 using SQL-----------------------
--- instead of today we can use getdate()-----------------
---------------------SCD Type 01-----------------------------
insert into product_stg values(3,'iphone15',65000);
insert into product_stg values(5,'iphone17',97000);

delete from product_stg

select * from product_stg 
select *  from product_dim

declare @today date='2024-01-01'
insert into product_dim 
select product_id,product_name,price,@today,'9999-12-31' from product_stg
where product_id not in(select product_id from product_dim)



select * from  product_dim
select * from product_stg 


declare @today date='2024-01-27'
update product_dim
set price=product_stg.price,last_update=@today
from product_stg 
where product_stg.product_id=product_dim.product_id