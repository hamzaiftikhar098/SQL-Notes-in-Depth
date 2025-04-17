--==============================================================================
--                            Day_6 Assignemnt_solution                   |
--==============================================================================
                            <---------------------------->

--==============================================================================
/* Q1- write a query to print emp name , their manager name and diffrence in their age (in days)
   for employees whose year of birth is before their managers year of birth */
--==============================================================================
select
		*
from employee e1 
inner join 
		employee e2 on e1.manager_id=e2.emp_id
where e1.dob < e2.dob

                         
