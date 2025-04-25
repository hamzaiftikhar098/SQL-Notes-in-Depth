--==============================================================================
--                            Day_6 Assignemnt_solution                   |
--==============================================================================
                            <---------------------------->

--==============================================================================
/* Q1- write a query to print emp name , their manager name and diffrence in their age (in days)
   for employees whose year of birth is before their managers year of birth */
--==============================================================================
select
		e1.emp_name,
		e2.emp_name as manager_name
from employee e1 
inner join 
		employee e2 on e1.manager_id=e2.emp_id
where e1.dob < e2.dob

 --                          <---------------------------->

--=========================================================================================================
/* Q2- write a query to find subcategories who never had any return orders in the month 
                 of november (irrespective of years) */
--=========================================================================================================
                        
select
		o.Sub_Category,
		Count(r.order_id) as orders_returned
from
		orders as o
left join
		returns as r
on 
		o.Order_ID=r.order_id
where 
		Datepart(month,o.Order_Date) =11
group by 
		o.Sub_Category
having 
		Count(r.order_id) = 0;
  -- --------------------------------------Provided Solution
select
    sub_category
from
    orders o
left join
    returns r
on
    o.order_id=r.order_id
where 
    DATEPART(month,order_date)=11
group by 
    sub_category
having
    count(r.order_id)=0;


--                          <---------------------------->

--===============================================================================================================================
/* Q3- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
write a query to find order ids where there is only 1 product bought by the customer. */
--===============================================================================================================================
 Select 
		Order_ID,
		COUNT(Product_ID) as number_of_products
 from orders
 group by Order_ID
 having COUNT(Product_ID) = 1
--                          <---------------------------->

--===============================================================================================================================
/* 4- write a query to print manager names along with the comma separated list(order by emp salary) of all employees 
           directly reporting to him. */
--===============================================================================================================================
select * from employee

select
		e2.emp_name as manager_name,
		STRING_AGG(e1.emp_name, ',') WITHIN GROUP (Order by e1.salary) as reporting_to_him
from employee e1
inner join employee e2
on e1.manager_id=e2.emp_id
group by e2.emp_name;

-- --------------------Provided Solution

select e2.emp_name as manager_name , string_agg(e1.emp_name,',') as emp_list
from employee e1
inner join employee e2 on e1.manager_id=e2.emp_id
group by e2.emp_name;

--                          <---------------------------->

--===============================================================================================================================
/* 5- write a query to get number of business days between order_date and ship_date (exclude weekends). 
          Assume that all order date and ship date are on weekdays only */
--===============================================================================================================================
select top 1 * from orders
select
		Order_ID,
		Order_Date,
		Ship_date,
		DATEDIFF(day,Order_Date,Ship_date) as diff_of_days
from orders

--                          <---------------------------->

--===============================================================================================================================
/*6- write a query to print 3 columns: category, total_sales and (total sales of returned orders)*/
--===============================================================================================================================

select
	o.Category,
	SUM(o.sales) AS total_sales,
	Sum(CASE
			WHEN
			r.order_id is not null THEN Sales
			ELSE 0
		END
	) AS total_sales_of_returned_orders
from
	orders as o
left join
	returns as r
	on o.Order_ID = r.order_id
group by
	o.Category;

-- provided solution:
select o.category,sum(o.sales) as total_sales
,sum(case when r.order_id is not null then sales end) as return_orders_sales
from orders o
left join returns r on o.order_id=r.order_id
group by category;

--                          <---------------------------->

--===============================================================================================================================
/* 7- write a query to print below 3 columns
       category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020) */
--===============================================================================================================================
select top 1 * from orders
SELECT
    category,
    SUM(
        CASE
            WHEN DATEPART(year, Order_Date) = 2019 THEN sales
            ELSE 0
        END
    ) AS total_sales_2019,
    SUM(
        CASE
            WHEN DATEPART(year, Order_Date) = 2020 THEN sales
            ELSE 0
        END
    ) AS total_sales_2020,
	avg(
        CASE
            WHEN DATEPART(year, Order_Date) = 2019 THEN sales
            ELSE 0
        END
    ) AS average_sales_2019,
	avg(
        CASE
            WHEN DATEPART(year, Order_Date) = 2020 THEN sales
            ELSE 0
        END
    ) AS averga_sales_2020
FROM 
    orders
GROUP BY 
    category;

--                          <---------------------------->

--===============================================================================================================================
/*8- write a query print top 5 cities in west region by average no of days between order date and ship date.*/
--===============================================================================================================================
select top 1 * from orders
select top 5
	City,
	Region,
	AVG(
		datediff(DD,Order_date,Ship_Date)
	) as n0_of_days
from 
	orders
where 
	Region = 'West'
group by Region,city
order by n0_of_days desc

--                          <---------------------------->

--===============================================================================================================================
/*9- write a query to print emp name, manager name and senior manager name (senior manager is manager's manager)*/
--===============================================================================================================================
select * from employee

-- we can see that ankits manager is rohit and that of rohits it mohit, so mohit is a senior manager.
-- first we need to reach the managers and then from manager to their manager.

SELECT 
	e1.emp_name,
	e2.emp_name as manager_name,
	e3.emp_name as senior_manager
FROM 
	employee e1 
INNER JOIN
	employee e2
	on
	e1.manager_id = e2.emp_id
	inner join employee e3 
	on e2.manager_id = e3.emp_id;

-- provided solution
select
    e1.emp_name,e2.emp_name as manager_name,
    e3.emp_name as senior_manager_name
from employee e1
inner join
        employee e2
    on
        e1.manager_id=e2.emp_id
inner join
        employee e3
    on e2.manager_id=e3.emp_id;