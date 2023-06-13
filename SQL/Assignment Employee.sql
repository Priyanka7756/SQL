CREATE TABLE empl(
 emp_id int NULL,
 emp_name varchar(50) NULL,
 salary int NULL,
 manager_id int NULL,
 emp_age int NULL,
 dep_id int NULL,
 dep_name varchar(20) NULL,
 gender varchar(10) NULL
) ;
insert into empl values(1,'Ankit',14300,4,39,100,'Analytics','Female');
insert into empl values(2,'Mohit',14000,5,48,200,'IT','Male');
insert into empl values(3,'Vikas',12100,4,37,100,'Analytics','Female');
insert into empl values(4,'Rohit',7260,2,16,100,'Analytics','Female');
insert into empl values(5,'Mudit',15000,6,55,200,'IT','Male');
insert into empl values(6,'Agam',15600,2,14,200,'IT','Male');
insert into empl values(7,'Sanjay',12000,2,13,200,'IT','Male');
insert into empl values(8,'Ashish',7200,2,12,200,'IT','Male');
insert into empl values(9,'Mukesh',7000,6,51,300,'HR','Male');
insert into empl values(10,'Rakesh',8000,6,50,300,'HR','Male');
insert into empl values(11,'Akhil',4000,1,31,500,'Ops','Male');

SELECT * FROM empl

/*--Write a sql query to find the details of employee with 3rd highest salary in each dept
--If there are less than 3 employees in a dept, return the details of emp with the lowest salary
--You can't make multiple CTEs and do union */

SELECT *
FROM empl a
WHERE ( SELECT COUNT(DISTINCT salary)
FROM empl b
WHERE b.salary >= a.salary AND b.dep_id = a.dep_id) = 3
OR ( SELECT COUNT(DISTINCT salary)
FROM empl b
WHERE b.dep_id = a.dep_id) < 3
AND salary = (SELECT MIN(salary)
FROM empl b
WHERE b.dep_id = a.dep_id);

/* with cte*/

with ct as (select *,dense_rank()over(partition by dep_name order by salary desc) rnk
from empl a) 
select *from ct a where rnk=3 and a.salary=(select  min(salary) from ct b where a.dep_id=b.dep_id group by b.dep_id);


/* Question 2 calls details*/


create table call_details  (
call_type varchar(10),
call_number varchar(12),
call_duration int
);
insert into call_details
values ('OUT','181868',13),('OUT','2159010',8)
,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);

/*--Write a sql query to identify phone numbers that satisfy below conditions
--The numbers have both incoming and outgoing calls
--The sum of duration of outgoing calls should be greater than sum of duration of incoming calls.*/

select* from call_details;

WITH outgoing_calls AS (SELECT call_number, SUM(call_duration) AS total_duration
FROM call_details
WHERE call_type = 'OUT'
GROUP BY call_number), 
incoming_calls AS (SELECT call_number, SUM(call_duration) AS total_duration
FROM call_details
WHERE call_type = 'INC'
GROUP BY call_number)
SELECT DISTINCT o.call_number
FROM outgoing_calls o
JOIN incoming_calls i ON o.call_number = i.call_number
WHERE o.total_duration > i.total_duration;


SELECT *
FROM call_details
 where lower(call_type in ('out','inc'))
GROUP BY call_number
HAVING 
 SUM(CASE WHEN call_type = 'OUT' THEN call_duration ELSE 0 END) >
    SUM(CASE WHEN call_type = 'INC' THEN call_duration ELSE 0 END);

