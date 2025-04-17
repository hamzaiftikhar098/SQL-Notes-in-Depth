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