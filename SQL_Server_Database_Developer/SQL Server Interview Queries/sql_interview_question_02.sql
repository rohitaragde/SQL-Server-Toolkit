-------------------SQL Interview Question 02--------------------------

create table Orders
(customer_id int,
 order_date date);

---- Write a query to find the customers who have made atleast 
--two consecutive orders

select * from Orders;

WITH consecutive_orders AS (
    SELECT 
        customer_id,
        order_date,
        LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_date 
    FROM 
        orders
)
SELECT 
    DISTINCT customer_id 
FROM 
    consecutive_orders 
WHERE 
    DATEDIFF(day, previous_order_date, order_date) = 1;






