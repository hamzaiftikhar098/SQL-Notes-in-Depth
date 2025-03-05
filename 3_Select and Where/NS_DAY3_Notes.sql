select *
from orders 
order by order_date desc
;
--to get distinct value of a column
select distinct order_date from orders
order by order_date;

select distinct(ship_mode),segment from orders;
select distinct ship_mode,segment from orders;

select distinct Ship_Mode from orders;

select distinct * from orders;
---filters-----
select * from orders
where ship_mode='First Class';

select * from orders
where order_date='2020-12-08';

select order_date,quantity 
from orders
where quantity != 5
order by quantity desc;


select * from orders
where order_date < '2020-12-08'
order by order_date desc
;


select * from orders
where order_date between '2020-12-08' and '2020-12-12'
order by order_date desc

select * from orders
where quantity between 3 and 5
order by quantity desc;

select distinct ship_mode from orders
where ship_mode in ('First Class','Same Day');


select * from orders
where quantity in (3, 5 , 4)
order by quantity desc;

select distinct ship_mode from orders
where ship_mode not in ('First Class','Same Day');


select distinct ship_mode from orders
where ship_mode >= 'Second Class'

select order_date, ship_mode,segment from orders
where ship_mode = 'First Class' and segment='Consumer'


select order_date, ship_mode,segment from orders
where ship_mode = 'First Class' or segment='Consumer'

select distinct ship_mode from orders
where ship_mode in ('First Class','Same Day');

select * from orders
where ship_mode = 'First Class' or ship_mode='Same Day'; --or filter always increase rows

select * from orders where quantity>5 and order_date<'2020-11-08' -- and will decrease;

select CAST(order_date as date) as order_date from orders
where CAST(order_date as date)= '2020-11-08'

select order_date, profit/sales as ratio,profit*sales as random_profit,getdate() as date_of_creation
from orders where order_date between '2020-11-08 00:00:00' and '2022-11-08 00:00:00' order by (profit/sales)
;
-- A quick Questions: Can we use alias in the where clause or not??
--pattern matching like operator
--Observe the case sensitivity/insensitivity also
select order_id,order_date,customer_name
from orders
where customer_name like 'Chris%';

select order_id,order_date,customer_name
from orders
where customer_name like 'CHRIS%';

select order_id,order_date,customer_name
from orders
where customer_name like '%SCHILD';

select order_id,order_date,customer_name
from orders
where customer_name like '%ven%';


select order_id,order_date,customer_name,upper(customer_name) as name_upper
from orders
where upper(customer_name) like 'A%A' ;

--What if we need to filter on the basis of number of specific characters before or after?
--Note the differnece between % and _: %l means l can be anywhere, but _l means l shall be at the second place
select order_id,order_date,customer_name
from orders
where customer_name like '_l%' ;
-- what if we want to ignore the % sign in the query
select order_id,order_date,customer_name
from orders
where customer_name like '_l%' escape '%' ;
--%--0 or more any characters
-- _ - > one character
-- []
--[abcd] second character should be any of x,y,z,c,x,v

-- carl cral
select order_id,order_date,customer_name
from orders
where customer_name like 'C[ara]%'


select order_id,order_date,customer_name
from orders
where customer_name like 'C[albo]%'

-- The negation of any character, For example we want that our second character shall not be a l b o
select order_id,order_date,customer_name
from orders
where customer_name like 'C[^albo]%';

-- we can also use the cpmbination of wildcard in a single like:
-- sometimes we want to be our character in any range for example between a and f (a,b,c,d,e,f)
select order_id,order_date,customer_name
from orders
where customer_name like 'C[e-h]%' order by customer_name
-- e, f , g, h
select order_id,order_date,customer_name
from orders
where order_id like 'CA-201[8-9]%'
order by customer_name;
2018, 2020

select * from orders where customer_id = 14

&,_,[],-,^

--- Handling Nulls
select * from orders where City is null

--========================

---order of execution of a queryy:
select * from orders
select order_id,order_date 
from orders
where order_date < '2020-12-08'
order by order_date


-- alias



--1) from 
--2) filters
--3) select 
--4) order

















 











