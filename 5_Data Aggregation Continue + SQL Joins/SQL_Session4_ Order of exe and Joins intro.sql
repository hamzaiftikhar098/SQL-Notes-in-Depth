-- Session 4: order of execution, and Joins (intro)

select student_id,count(*) as total_records,count(distinct marks)  as distinct_marks
from exams
where subject in ('Chemistry','Physics')
group by student_id
having count(*)=2 and count(distinct marks)=1
;
--we can put the coulmn in group by or the aggregated column in the select statement
select student_id,marks , count(1) as total_rows
from exams
where subject in ('Chemistry','Physics')
group by student_id,marks 
having count(1)=2
order by student_id;
-------------------------------------------------

-- order of execution:

select region,SUM(sales) as total_sales
from orders
group by region 
having SUM(sales) > 10500

select region,SUM(sales) as total_sales, AVG(sales) as average_sales
from orders
group by region 
having SUM(sales) > 10500

 -- sum(sales)= 100,000
-- select: shows the ouput but not to compute
-- there is a diff bertween showing something and computing something
-- we concluded that select not only shows but also triggers calculations inside it.

-- A very famous interview Question: Find the duplicate rows in the data set.
select * from orders
select order_id, count(order_id) as number_of_duplicates from orders 
group by order_id having count(*) > 1

-- we use more than 1 tables for our operations. So, in order to get the desired result, we need to join them.
-- for this purpose, we have a keyword called JOIN

SELECT * FROM orders
SELECT * FROM returns
-- what if i want to know the sales, category,return reasonn, product name of the orders which are returned, 
--becasue either of the table does not give the full infor about this question.
-- Types of joins: inner join, left join, right join
select * from orders
inner join returns on
orders.order_id = returns.order_id

select orders.order_id,orders.product_name, orders.sales, orders.category, returns.return_reason from orders
inner join returns on
orders.order_id = returns.order_id
-- what amount sum(sales) did we lose on returns.

select SUM(orders.sales) as returned_sales_Wapis from orders
inner join returns on
orders.order_id = returns.order_id

select SUM(sales) from orders

--  what category of the product performed the worst

select orders.category, COUNT(returns.order_id) as num_of_orders_returned from Orders
inner join returns on
orders.order_id = returns.order_id
group by orders.category
order by num_of_orders_returned desc
-- office supplies

--  what category of the product performed the best

select top 1 orders.category, COUNT(returns.order_id) as num_of_orders_returned from Orders
inner join returns on
orders.order_id = returns.order_id
group by orders.category
order by num_of_orders_returned asc
-- Technology
--====================================================