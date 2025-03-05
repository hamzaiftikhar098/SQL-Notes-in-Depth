-- Some discussion about the orde rof execution of a querry:
-- what is the order of execution of this querry?
select top 5*
from orders 
order by order_date, Discount
;
--to get distinct value of a column
select distinct order_date from orders
order by order_date;

-- note combination of columns distincts (how it works)
select distinct ship_mode,segment from orders
-- Note the following: keep this in mind: (the combination of sorting)
select distinct ship_mode,segment from orders order by ship_mode 

select distinct * from orders;
---filters-----
-- Remeber: strings and Dates must be written single quotes
select * from orders
where ship_mode='First Class';

select * from orders
where order_date='2020-12-08';

-- observe the query, and tell the order of execution also
select order_date,quantity 
from orders
where quantity != 5
order by quantity desc;

-- for finding below some point
select * from orders
where order_date < '2020-12-08'
order by order_date desc
;

-- for fidning values in a particular period, includes both the upper and lower limits
select * from orders
where order_date between '2020-12-08' and '2020-12-12'
order by order_date 
-- The between includes upper and lower limit also
select * from orders
where quantity between 3 and 5
order by quantity desc;
-- here is way to avoid upper and lower limit inclusion
select * from orders
where quantity > 3 and quantity <5
order by quantity desc;

-- filtering on the basis of a combination (a list of values)
-- Some discussion about intervals, continuous, and discrete values of filters.
select distinct ship_mode from orders
where ship_mode in ('First Class','Same Day');

-- note the diff (BETWEEN, >,< IN)
select * from orders
where quantity in (3, 5 , 4)
order by quantity desc;

-- Some discussion about IN and NOT IN (the former gives .... and the later gives ....)
select distinct ship_mode from orders
where ship_mode not in ('First Class','Same Day');

--NOTE THAT: .... >, <  ASCI Values..
select distinct ship_mode from orders
where ship_mode > 'Second Class'
--==================================================================
-- This was all about filters on one columns, now we will discuss about the filters on the more than 1 columns
-- Give us all the record from consumer segment having ship mode as First Class.
select order_date, ship_mode,segment from orders
where ship_mode = 'First Class' and segment='Consumer'

-- someone tell why the below does not work?
select order_id from orders where category != 'Technology' and category = 'Furniture'

select order_date, ship_mode,segment from orders
where ship_mode = 'First Class' or segment='Consumer'

select distinct ship_mode from orders
where ship_mode in ('First Class','Same Day');
 
-- IN and (=,or) behave the same

select * from orders
where ship_mode = 'First Class' or ship_mode='Same Day'; --or filter always increase rows

select * from orders where quantity>5 and order_date<'2020-11-08' -- and will decrease;

-- Think of a situation where we have date time also but we just want to check for date only, then what? we use cast function
select CAST(order_date as date) as order_date_new, * from orders
where CAST(order_date as date) = '2020-11-08'

select CAST(order_date as date) as order_date_new, * from orders
where CAST(order_date as date) = '2020-11-08'

-- Creating new columns in sql
select *,profit/sales as ratio
from orders

EXEC sp_rename 'orders.Sales', 'sales', 'COLUMN';
select * from orders
-- lets us at we want to find the price of each item
select Product_name,((sales/Quantity)-(Profit/Quantity)) as Actual_price,sales/Quantity as unit_price, sales, 
Profit/Quantity as prfit_per_unit from  orders

-- some times we want to get the current timestamp along with results, we can use getdate
select *,profit/sales as ratio,profit*sales as tukka,getdate() as total
from orders
where order_date between  '2022-11-01 12:00:00' and  '2022-11-01 12:40:00'
order by order_date
;
-- Till now we have been seen the filter where we were sure, but what if we have some idea about the filter 
-- and not he whole info? then we uwe pattern matching:
-- wildcard characters: %
--pattern matching like operator
select order_id,order_date,customer_name
from orders
where customer_name like 'Chris%';

select order_id,order_date,customer_name
from orders
where customer_name like '%t';

select order_id,order_date,customer_name
from orders
where customer_name like '%ven%';


select order_id,order_date,customer_name,upper(customer_name) as name_upper
from orders
where upper(customer_name) like 'A%A' ;


select order_id,order_date,customer_name
from orders
where customer_name like '_l%' ;
--%--0 or more any characters
-- _ - > one character

select order_id,order_date,customer_name
from orders
where customer_name like 'C[albo]%'


select order_id,order_date,customer_name
from orders
where customer_name like 'C[^albo]%';


select order_id,order_date,customer_name
from orders
where order_id like 'CA-20[][1-2]%'
order by customer_name



















 











