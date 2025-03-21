use AdventureWorksDw2019

create table customers
(customer_name varchar(10),
 first_name varchar(11),
 middle_name varchar(10),
 last_name varchar(10))


 insert into customers values('Rohit A Ragde','Rohit',NULL,'Ragde')
 insert into customers values('Smita Ragde','Smita',NULL,'Ragde')
 insert into customers values('Keyur','Keyur',NULL,'Dhande')


 with cte as
 (
 select *,
 len(customer_name)-len(replace(customer_name,' ','')) as no_of_spaces,
 charindex(' ',customer_name) as space_index,
 charindex(' ',customer_name,charindex(' ',customer_name)+1) as second_space_index
 from customers
 )

 select *,
   case when no_of_spaces=0 then customer_name
   else left(customer_name,space_index-1)
  ---else substring(customer_name,1,space_index-1)
 end as first_name,
  case when no_of_spaces<=1 then null
   else substring(customer_name,space_index+1,second_space_index-space_index)
   end as middle_name,
   case when no_of_spaces=0 then null
   when no_of_spaces=1 then substring(customer_name,space_index+1,len(customer_name)-space_index)
   when no_of_spaces=2 then substring(customer_name,second_space_index+1,len(customer_name)-second_space_index)
   end as last_name
 from cte 
 