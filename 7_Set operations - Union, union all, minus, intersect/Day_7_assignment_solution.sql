--==============================================================================
--                            Day_7 Assignemnt_solution                   |
--==============================================================================
--                            <---------------------------->

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

--==============================================================================
/* Q1- Write a query to produce below output from icc_world_cup table.
       team_name, no_of_matches_played , no_of_wins , no_of_losses */
--==============================================================================
select * from icc_world_cup

select team_1 as team, case when team_1=winner then 1 else 0 end as win_flag from icc_world_cup



 --                          <---------------------------->

--=========================================================================================================

/*Run below script to create drivers table:

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');*/
 
--=========================================================================================================
create table
	drivers
		(id varchar(10),
		start_time time,
		end_time time,
		start_loc varchar(10),
		end_loc varchar(10));

insert into
	drivers
values
	('dri_1', '09:00', '09:30', 'a','b'),
	('dri_1', '09:30', '10:30', 'b','c'),
	('dri_1','11:00','11:30', 'd','e');
insert into
	drivers
values
	('dri_1', '12:00', '12:30', 'f','g'),
	('dri_1', '13:30', '14:30', 'c','h');
insert into
	drivers
values
	('dri_2', '12:15', '12:30', 'f','g'),
	('dri_2', '13:30', '14:30', 'c','h');    
	
-- Solution starts here:
select * from drivers

--===============================================================================================================
/* 2- write a query to print first name and last name of a customer using orders table(everything after 
        first space can be considered as last name) customer_name, first_name,last_name */
--=============================================================================================================
select Order_Id, Customer_Name from orders













