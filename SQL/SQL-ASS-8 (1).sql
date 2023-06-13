CREATE TABLE employee_details(emp_id varchar(3) NOT NULL,
full_name varchar(20) NULL,
manager_id varchar(5) NULL,
date_of_joining date NULL,
city varchar(15)
)
 
INSERT INTO employee_details VALUES('121', 'John Snow', '321', '01/31/2019', 'Toronto');
INSERT INTO employee_details VALUES('321', 'Walter White', '986', '01/30/2020', 'California');
INSERT INTO employee_details VALUES('421', 'Kuldeep Rana', '876', '11/27/2021', 'New Delhi')

CREATE TABLE employee_salary(emp_id varchar(3) NOT NULL,
project varchar(2) NULL,
salary int NULL,
variable int NULL
)
 
INSERT INTO employee_salary VALUES('121', 'P1', '8000', '500');
INSERT INTO employee_salary VALUES('321', 'P2', '10000', '1000');
INSERT INTO employee_salary VALUES('421', 'P1', '12000', '0');
INSERT INTO employee_salary VALUES('429', NULL , '12000', '0');


/*Q1. Write an SQL query to fetch all the Employees who are also managers from the EmployeeDetails table*/
select * from employee_details;
select* from employee_salary;

select b.*,a.*
from employee_details a inner join employee_salary b on b.emp_id=a.emp_id;

SELECT a.*
FROM employee_details a
INNER JOIN employee_salary b ON a.emp_id = b.emp_id
WHERE a.emp_id IN (
  SELECT manager_id
  FROM employee_details
)

/*Q2. Write an SQL query to fetch duplicate records from EmployeeDetails (without considering the primary key – EmpId).*/
select emp_id,full_name,manager_id,date_of_joining,city,count(*)
from employee_details
group by emp_id
having count(*)>1;

/* Q3. Write an SQL query to remove duplicates from a table without using a temporary table.*/
select distinct*
from employee_details;

/* with CTE */
with ct as (select* , row_number()over( order by emp_id) as new_n from employee_details)
select * from ct where new_n>1;

with ct as (select* , row_number()over( order by emp_id) as new_n from employee_details)
delete from ct
where new_n>1;

/* Q4. Write an SQL query to fetch only odd rows from the table.*/
select *
from employee_details
where emp_id%2<>0;
/* Q5. Write an SQL query to fetch only even rows from the table.*/
select *
from employee_details
where emp_id%2=0;

/* Q6. Write an SQL query to create a new table with data and structure copied from another table.*/
create table emp2(emp_id varchar(3) NOT NULL,
full_name varchar(20) NULL,
manager_id varchar(5) NULL)
INSERT INTO emp2 VALUES('121', 'John Snow', '321');

CREATE TABLE new_table
AS
SELECT * FROM emp2;
select*from new_table


/*Q7. Write an SQL query to create an empty table with the same structure as some other table.*/
CREATE TABLE new_table2 AS 
SELECT * FROM emp2 WHERE 1=0;
select * from new_table2;

/* Q8. Write an SQL query to fetch top n records.*/
select*
from employee_details 
limit 4

/* Q9. Write an SQL query to find the nth highest salary from a table. 2nd*/
select salary
from employee_salary
order by salary desc
limit 2,1;
/* with subquery*/
select max(salary)
from employee_salary
where salary<>(select max(salary)from employee_salary)

/* Q10. Write SQL query to find the 3rd highest salary from a table without using the TOP/limit keyword.*/
select max(salary)
from employee_salary where salary<(select max(salary)
from employee_salary
where salary<(select max(salary)from employee_salary));