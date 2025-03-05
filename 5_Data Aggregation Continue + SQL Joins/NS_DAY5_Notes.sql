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
--create table returns (order_id  varchar(10),return_reason varchar(10))
-- database joins
select * from dbo.orders

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

-- A very famous interview Question: Find the duplicate (which exists more than one time=) rows in the data set.
/*
A very famous interview Question: Find the duplicate (which exists more than one time=) 
rows in the data set
if something exists more than 1 time, its count must be greater than 1.
*/

select order_id, count(order_id) as number_of_duplicates from orders 
group by order_id having count(*) > 1
order by number_of_duplicates desc

-- we use more than 1 tables for our operations. So, in order to get the desired result, we need to join them.
-- for this purpose, we have a keyword called JOIN

SELECT * FROM orders --partial info is in this table
SELECT * FROM returns --partial info is in this table
-- if we want to get full info, we need to join these tables
-- what if i want to know the sales, category,return reasonn, product name of the orders which are returned, 
--becasue either of the table does not give the full infor about this question.
-- Types of joins: inner join, left join, right join
select * from orders
inner join returns on
orders.order_id = returns.order_id

-- syntax of join
/*
select cols_names from TABLE1 
JOIN TYPE TABLE2
ON
T1.col_name=T2.col_name
*/

select orders.order_id,orders.product_name, orders.sales, orders.category, returns.return_reason 
from orders
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


db_name.schema_name.table_name.column






select * from orders o inner join returns r on o.order_id= r.order_id
select * from orders order by order_id
select * from returns order by order_id
select o.order_id,o.product_id,r.return_reason
from orders o
inner join returns r on o.order_id=r.order_id;
--=====================================================================================
--Types of joins
--1. Inner join (returns all the common entries, for which we find a match)
select o.order_id,r.order_id, o.product_id,r.return_reason
from orders o
join returns r on o.order_id=r.order_id;





--2. Left join (it returns the macthing rows, but also the rows from left table which donot have a match)
-- concept of left and right join(first mentioned is left, and second mentioned tables is right table)
select o.order_id,r.order_id, r.return_reason
from orders o
left join returns r on o.order_id=r.order_id;

--3. right join (it returns the macthing rows, but also the rows from right table which donot have a match)
-- concept of left and right join(first mentioned is left, and second mentioned tables is right table)
select o.order_id,r.order_id, r.return_reason
from orders o
right join returns r on o.order_id=r.order_id;


select o.order_id,r.order_id, r.return_reason
from returns r
right join orders o on o.order_id=r.order_id;










--3. Right join
-- This is the case when we have 1 to many, or many to 1 relationship
select r.*,o.Order_ID,o.Order_Date 
from orders o
inner join
returns r on
r.order_id=o.order_id

-- left table orders, and right table is returns table
/*
The left join will returns all the entries from the orders table (9994)
and the matching rows (where orderID matches) from the right table (returns),
if there are no matches in the right table, there will be null mentioned
*/
select o.Order_ID,o.Order_Date,r.*
from orders o
left join
returns r on
r.order_id=o.order_id
where o.Order_ID='CA-2018-143336'

select order_id,product_id from dbo.orders where Order_ID ='CA-2018-143336'
select order_id, return_reason from dbo.returns where Order_ID ='CA-2018-143336'

-- left table orders, and right table is returns table
select r.*,o.Order_ID,o.Order_Date 
from orders o
right join
returns r on
r.order_id=o.order_id
--===============
-- A Quick Question: show the entries with duplicates, and show the top of them
SELECT top 5 order_id, customer_id, COUNT(order_id) AS duplicate_count
FROM orders
GROUP BY order_id, customer_id
HAVING COUNT(order_id) > 1
ORDER BY duplicate_count DESC
--======================


--Q1 In what case inner and left/right join produce the same results.



-- Ans: If the right table has all the value which are also in left then, right join 
-- will give the same result as the inner join. This is also the same of the reverse case
--Q2 In what case inner, left and right joins produce the same results.

select o.Order_ID,o.Product_ID,r.return_reason from
orders o inner join returns r on o.Order_ID=r.order_id
order by order_id

select o.order_id,o.product_id,r.return_reason, r.order_id as return_order_id
from orders o
left join returns r on o.order_id=r.order_id
;

--- Find the orders which are not returned
--- find the products which are returned: (product_name, return_reason)
select o.product_name,r.return_reason from orders as o
inner join returns as r
on o.order_id=r.order_id

---Find the products,along with return reason which are not returned
select o.product_name,r.return_reason from orders as o
left join returns as r
on o.order_id=r.order_id
where r.return_reason is NULL




-- A quick tip, inner join will give the orders only which are returned since returns table
-- contains only those which are returned, But left join will give orders which are both
-- returned as well as not returned, so applying a filter there will serve the purpose.
select o.order_id,o.product_id,r.return_reason, r.order_id as return_order_id
from orders o
left join returns r on o.order_id=r.order_id
where r.return_reason is Null

select o.order_id, return_reason 
from orders as o 
INNER JOIN returns as r ON o.order_id=r.order_id
--** Why does the right not give any results here?

-- What amount of sales did we lose due to returns from each return reason?
select r.return_reason,sum(sales) as total_sales
from orders o
inner join returns r on o.order_id=r.order_id
group by r.return_reason
order by total_sales
--===============================
-- First we will make two tables
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary INT,
    manager_id INT,
    emp_age INT
);

INSERT INTO employee (emp_id, emp_name, dept_id, salary, manager_id, emp_age) VALUES
(1, 'Hamza', 100, 10000, 4, 39),
(2, 'Ali', 100, 15000, 5, 48),
(3, 'Waqas', 100, 10000, 4, 37),
(4, 'Areeba', 100, 5000, 2, 16),
(5, 'Wajeeh', 200, 12000, 6, 55),
(6, 'Ibraheem', 200, 12000, 2, 14),
(7, 'Areej', 200, 9000, 6, 19),
(8, 'Aqsa', 200, 5000, 2, 12);

select * from employee
select * from department
--
CREATE TABLE department (
    dep_id INT PRIMARY KEY,
    dep_name VARCHAR(100)
);

INSERT INTO department (dep_id, dep_name) VALUES
(100, 'Analytics'),
(200, 'IT'),
(300, 'HR'),
(400, 'Text Analytics');





--cross join
select * from employee
select * from department
select e.emp_id,e.emp_name,e.dept_id,d.dep_name from 
employee e
inner join department d on e.dept_id=d.dep_id;

select e.emp_id,e.emp_name,e.dept_id,d.dep_name from 
employee e
inner join department d on e.dept_id=d.dep_id;
-- there is also no restriction that colum names on which we join should be the same
select e.emp_id,e.emp_name,e.dept_id,d.dep_name from 
employee e
left join department d on e.dept_id=d.dep_id

select e.emp_id,e.emp_name,e.dept_id,d.dep_id,d.dep_name from 
employee e
right join department d on e.dept_id=d.dep_id;

-- What if we dont give any
select * from employee,department

-- Using inner join to make cross join (each record gets connected with every other record)
select * from employee inner join
department on 1=1
order by emp_id
-- since 1=1, therefore each row will be joined with every other row in next table
-- We can obtain the functionality of left and right joins from any of the join condition
--- we do this by swapping the table from left to right or vice versa.
-- in real use cases, we do not use right join, instead we use left and when we want to obtain the 
-- functionality of right join, we just swap the table name from right to left.

--- ======================
-- THE FULL OUTER JOIN
-- This gives all the entries from all the table
-- This contains the results of inner, left and right join combined


select * from employee;
select * from department;
select * from employee;

select *
from department d
left join 
employee e on
e.dept_id=d.dep_id

-- Note that: the join type tells the restriction, inner means only matching,
-- while left and right mean matching and non matching also.

/*
let us see different restrictions on the default behavior of joins
inner: retain only matching and discrard whatever is not matching
left join: Retain matching in both, but also retain all record from the left table by putting nulls 
           against the records which have no related info.
*/

-- Note that: Pay Special attention to learning the internals of left, right, full outer join 
---================================================================================
--====================JOINING MORE THAN TWO COLUMNS===============================
create table people
(
manager varchar(20),
region varchar(20)
)

INSERT INTO people (manager, region) 
values
('ankit','west'),
('deepak','east'),
('vishal','central'),
('sanjay','south');
--=============Assignment solution
select * from orders
select * from returns


--Q1:write a query to get region wise count of return orders
-- tell us what is count of returns in each region.

select o.region,COUNT(r.order_id) as return_count 
from orders o
inner join returns r
on o.order_id=r.order_id
group by o.region
order by return_count desc










select o.Region, COUNT(distinct(r.order_id)) as total_returns from
orders as o inner join
returns as r on o.order_id=r.order_id
group by o.Region
order by total_returns desc

--2- write a query to get category wise sales of orders that were not returned
select o.Category, SUM(o.sales) as total_sales from 
orders o left join 
returns r on o.Order_ID=r.order_id
where r.order_id is null
group by o.Category

--Q3- write a query to print dep name and average salary of employees in that dep.
select * from employee
select * from department

select d.dep_name,AVG(e.salary) from employee e
inner join department d
on e.dept_id=d.dep_id
group by d.dep_name
--=======================
--Q4- write a query to print dep names where none of the emplyees have same salary.
select * from employee
select * from department
-- find the departments where employess have the same salary:
-- Here is the sol:
-- This gives the departments in which emplyees have the same salary (then apply not)
--NOTE THAT  A DEPARTMENT IN WHICH EVEN 2 EMPS HAVE THE SAME SALARY WILL HAVE THE COUNT
-- OF DISTINCT SALARIES LESS THAN THE COUNT OF SALARIES.
/* for example if there are 5 employees and if two of them have the same salaries the count
of disticnt salairs = 4 but count of salaries is 5
This means distinct(count)< count */
select d.dep_name, COUNT(e.salary) as salary,
count(distinct(e.salary)) as distinct_salarie  from employee e
inner join department d
on e.dept_id=d.dep_id
group by d.dep_name
having not(count(e.salary)!=count(distinct(e.salary)))

--Q5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)
select distinct return_reason from returns

select top 5 Sub_Category from orders
select top 5 return_reason from returns

select o.Sub_Category, count(distinct(r.return_reason)) as total_return_reasons from orders o
inner join
returns r on o.Order_ID=r.order_id
group by o.Sub_Category
having count(distinct(r.return_reason))=3
order by o.Sub_Category
-- The below query is less performant as it has an initial extra filter as it is of no use.
select o.Sub_Category, count(distinct(r.return_reason)) as total_return_reasons from orders o
inner join
returns r on o.Order_ID=r.order_id
where r.return_reason in ('Bad Quality','Others','Wrong Items')
group by o.Sub_Category
having count(distinct(r.return_reason))=3
order by o.Sub_Category
--6- write a query to find cities where not even a single order was returned.
--Q

select o.City,Count(r.order_id) as total_returns from 
orders o left join
returns r on o.order_id=r.order_id
where r.order_id is null
group by o.City
having Count(r.order_id)=0

select o.City, Count(r.order_id) from 
orders o left join
returns r on o.order_id=r.order_id
where r.return_reason is null
group by o.City
having COUNT(r.return_reason)=0


select city
from orders o
left join returns r on o.order_id=r.order_id
group by city
having count(r.order_id)=0
--====================================================================
--Q7-write a query to find top 3 subcategories by sales of returned orders in east region
select top 3 o.sub_category, SUM(o.sales) as total_Sales from 
orders o inner join returns r on
o.order_id=r.order_id
where o.region= 'East'
group by o.Sub_Category
order by total_Sales desc
--===========================================================
--Q8 write a query to print dep name for which there is no employee
select * from department
select * from employee

select * from department d
left join employee e
on d.dep_id=e.dept_id
where e.dept_id is null

select d.dep_name, e.emp_name
from department d left join employee e
on d.dep_id=e.dept_id
where e.emp_name is null

select d.dep_id,d.dep_name
from department d 
left join employee e on e.dept_id=d.dep_id
group by d.dep_id,d.dep_name
having count(e.emp_id)=0;



select d from people


select o.order_id,o.product_id,r.return_reason,p.manager
from orders o
left join returns r on o.order_id=r.order_id
inner join people p on o.region=p.region
;

select * from people
create table people
(
manager varchar(20),
region varchar(10)
)

insert into people
values ('Ankit','West')
,('Deepak','East')
,('Vishal','Central')
,('Sanjay','South')



















