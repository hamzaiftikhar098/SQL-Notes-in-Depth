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


