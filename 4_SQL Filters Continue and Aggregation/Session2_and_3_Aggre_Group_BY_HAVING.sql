--- filtering null values 
select * from orders
where city is null;
select * from orders
where city is not null ;
---aggregation (1 value aggregations)
--What is the behavuoir of order by, top n, and where..

select 
sum(sales) as total_sales
from orders;
select sales from orders;

23
34
56      ()
76
.
.80


-- Note that they all give one row only:
select
sum(sales) as total_sales
,max(sales) as max_sales
,min(profit) as min_profit
,avg(profit) as avg_profit
from orders

-- sum: (works on integre, float data type) , count: (this works on both, inetegers and string)
12+3+5, hamza,Ali...

select
count(sales) as total_sales_of_the_month
from orders

select order_id,order_date from orders
order by sales
-- order by is used to sort the output (asc, desc)

select
sum(order_id)
from orders
select SUM(sales) from orders
select distinct(region) from orders

select region,
sum(sales) as total_sales
,max(sales) as max_sales
,min(profit) as min_profit
,avg(profit) as avg_profit
from orders
group by region

--==> 1 from, 2 groups 3,select 4, order by (sort)

-- Question: What if we want to know these things in each region: 
-- One way is to use where filter.
select
sum(sales) as total_sales
,max(sales) 
,min(profit) 
,avg(profit) 
from orders
where orders.Region in ('East','West')
-- But the problem is that, for each region we will have to write a separate query, for example 
--for East region, for West region separate. 

select  region, count(*) as cnt
,sum(sales) as total_sales
,max(order_date) as max_sales
,min(profit) as min_profit
,avg(profit) as avg_profit
from orders where order_id > '1374'
group by region
order by region desc


--1 from==> 2 where ==>

--group by (this works as a pivot table)
select region, count(*) as cnt
,sum(sales) as total_sales
,max(sales) as max_sales
,min(profit) as min_profit
,avg(profit) as avg_profit
from orders
group by region;

select region,category,sum(sales) as total_sales
from orders
group by category

-- when we use group by, in select statement we can use only those columns which are in either group by or 
-- are in the aggregation.
-- A very famous interview Question:
-- oserve the order by here, comb of grouping
select region, count(*) as cnt
,sum(sales) as total_sales
,max(sales) as max_sales
,min(profit) as min_profit
,avg(profit) as avg_profit
from orders
group by region;

select top 5 region, sales from Orders where region= 'East'
select top 5 region, sales from Orders where region= 'South'

---------------
---------------
--------------
---------------

select region,category,sum(sales) as total_sales
from orders
group by region,category order by region, category


select sum(sales) as total_sales
from orders
group by region

-- Discussion of how whether we can order by any column here? 
-- The diff of usage of order by with and without group by clauses
-- discussion of order of execution here
select top 2 region,sum(sales) as total_sales
from orders
where profit>50 -- this filter is on the original table
group by region
order by total_sales desc
;

-- Discussion of filter in the group by here
-- We can use only those columns in the having which are either in group by or in select statement.
-- But this behaviour is not valid for where clause.
--why will this not work

-- find the categories where total sales is greater than 100000 (sales is greater than 1000)
select sub_category from Orders where sales > 10000

select sub_category,sum(sales) as total_sales
from orders
group by sub_category
having sum(sales) > 100000 or city= 'Newark'
order by total_sales desc;
-- Uses of Alias.
select SUM(sales) from orders
select SUM(sales) as total_sales from orders

select sales from Orders where SUM(sales) as total_sales > 10000

select *
from orders
where sum(profit)>50

select top 5 sub_category,sum(sales) as total_sales      --sum(sales) = total_sales, x=y=2
from orders
where profit>50
group by sub_category
having sum(sales) > 100000
order by total_sales desc
--discussion of using alias in the having
--detailed discussion on alises here: where to use where not to use

select top 5 sub_category,sum(sales) as total_sales      --sum(sales) = total_sales, x=y=2
from orders
where profit>50
group by sub_category
having sum(sales) > 100000 -- we can not use alias in having(reason)
order by total_sales desc

-- join























