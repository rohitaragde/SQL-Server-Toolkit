------------------------SCD Type 02----------------------------------
create table product_stg
(product_id int,
product_name varchar(20),
price decimal(9,2));



create TABLE product_dim(
 product_key int identity(1,1) primary key,
    Product_id  INT,
    Product_Name VARCHAR(50),
    Price   DECIMAL(9,2),
 start_date date,
 end_date date
);

insert into product_stg values(1,'iphone13',25000);
insert into product_stg values(3,'iphone15',90000);

delete from product_stg

select * from product_stg 
select *  from product_dim


declare @today date='2024-01-25'
update product_dim
set end_date=dateadd(day,-1,@today)
from product_stg 
where product_stg.product_id=product_dim.product_id
and end_date='9999-12-31'


declare @today date='2024-01-25'
insert into product_dim 
select product_id,product_name,price,@today,'9999-12-31' from product_stg
