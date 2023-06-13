
CREATE TABLE salary (
    id INT PRIMARY KEY,
    employee_id INT,
    amount DECIMAL(10,2),
    pay_date DATE);
INSERT INTO salary (id, employee_id, amount, pay_date)
VALUES (1, 1, 9000.00, '2017-03-31'),
       (2, 2, 6000.00, '2017-03-31'),
       (3, 3, 10000.00, '2017-03-31'),
       (4, 1, 7000.00, '2017-02-28'),
       (5, 2, 6000.00, '2017-02-28'),
       (6, 3, 8000.00, '2017-02-28');
       
select*from salary;
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    department_id INT
);	
INSERT INTO employee (employee_id, department_id)
VALUES (1, 1),
       (2, 2),
       (3, 2);
----------------------------------------------------------------------------------------------------------------------
select*from employee;
# Q.1 Given two tables below, write a query to display the comparison result (higher/lower/same) of 
# the average salary of employees in a department to the company’s average salary.	
-- | pay_month | department_id | comparison  |	
-- |-----------|---------------|-------------|	
-- | 2017-03   | 1             | higher      |	
-- | 2017-03   | 2             | lower       |	
-- | 2017-02   | 1             | same        |	
-- | 2017-02   | 2             | same        |	

SELECT DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
  e.department_id,
CASE WHEN AVG(s.amount) > (SELECT AVG(amount) FROM salary) THEN 'higher'
WHEN AVG(s.amount) < (SELECT AVG(amount) FROM salary) THEN 'lower' ELSE 'same'
END AS comparison
FROM salary s JOIN employee e ON s.employee_id = e.employee_id
GROUP BY pay_month, e.department_id;

--------------------------------------------------------------------------------------------------------------------
# Q.2 Write an SQL query to report the students (student_id, student_name) being “quiet” in ALL exams. A “quite” student is the one
# who took at least one exam and didn’t score neither the high score nor the low score.

select *from exam;

WITH ct AS (SELECT student_id, MIN(score) AS min_score, MAX(score) AS max_score
  FROM Exam
  GROUP BY student_id),
  ct2 AS (SELECT s.student_id, s.student_name
  FROM Student s JOIN Exam e ON s.student_id = e.student_id
JOIN ct ON e.student_id = ct.student_id
  WHERE ct.min_score != e.score
AND ct.max_score != e.score
GROUP BY s.student_id, s.student_name
  HAVING COUNT(DISTINCT e.exam_id) = (SELECT COUNT(*) FROM Exam))
SELECT * FROM ct2;



-------------------------------------------------------------------------------------------------------
# Q.3 Write a query to display the records which have 3 or  more consecutive rows and the amount of people more than 100(inclusive).

select*from stadium;
SELECT s.id, s.visit_date, s.people
FROM stadium s, stadium s2, stadium s3
WHERE s.people >= 100 AND s2.people >= 100 AND s3.people >= 100 
AND s.id = s2.id  AND s.id = s3.id 
AND s.people >= 100 AND s2.people >= 100 AND s3.people >= 100 
GROUP BY s.id
HAVING COUNT(*) >= 3;


------------------------------------------------------------------------------------------------------
# Q.4

# Write an SQL query to find how many users visited the bank and didn’t do any transactions, 
# how many visited the bank and did one transaction and so on.


SELECT transactions_count, COUNT(*) as visits_count
FROM (SELECT user_id, COUNT(*) as transactions_count
FROM Transactions
GROUP BY user_id) as t
RIGHT JOIN (SELECT user_id
FROM Visits
GROUP BY user_id) as v
ON t.user_id = v.user_id
GROUP BY transactions_count;
---------------------------------------------------------------------------------------------------------------------
# Q.5 Write an SQL query to generate a report of period_state for each continuous interval of days in the period from 2019–01–01 to 2019–12–31.

select*from failed;
select*from Succeeded ;
WITH t1 AS(SELECT MIN(success_date) AS start_date,MAX(success_date) AS end_date,state
FROM(SELECT success_date , DATE_SUB(success_date, INTERVAL ROW_NUMBER() OVER(ORDER BY success_date) DAY) AS diff, 

FROM succeeded
WHERE success_date BETWEEN "2019-01-01" AND "2019-12-31") AS a
GROUP BY diff),t2 AS(
SELECT MIN(fail_date) AS start_date, 
MAX(fail_date) AS end_date, state
FROM(SELECT fail_date, DATE_SUB(fail_date, ROW_NUMBER() OVER(ORDER BY success_date) DAY) as diff2,
FROM failed WHERE fail_date BETWEEN "2019-01-01" AND "2019-12-31") AS b GROUP BY diff)
SELECT CASE WHEN c.state = 1 THEN "succeeded" ELSE "failed"
END AS period_state, start_date, end_date
FROM (SELECT *FROM t1 UNION ALL
SELECT * FROM t2) AS c
  ORDER BY start_date
  


  
  --------------------------------------------------------------------------------------------------------------------
  # Q.6 Write an SQL query to report how many units in each category have been ordered on each day of the week.

select *from orders
select*from items
SELECT i.item_category AS category,
  SUM(CASE WHEN DAYOFWEEK(o.order_date) = 2 THEN o.quantity ELSE 0 END) AS monday,
SUM(CASE WHEN DAYOFWEEK(o.order_date) = 3 THEN o.quantity ELSE 0 END) AS tuesday,
SUM(CASE WHEN DAYOFWEEK(o.order_date) = 4 THEN o.quantity ELSE 0 END) AS Wednesday,
SUM(CASE WHEN DAYOFWEEK(o.order_date) = 5 THEN o.quantity ELSE 0 END) AS Thursday,
SUM(CASE WHEN DAYOFWEEK(o.order_date) = 6 THEN o.quantity ELSE 0 END) AS Friday,
SUM(CASE WHEN DAYOFWEEK(o.order_date) = 7 THEN o.quantity ELSE 0 END) AS Saturday,
SUM(CASE WHEN DAYOFWEEK(o.order_date) = 1 THEN o.quantity ELSE 0 END) AS Sunday
FROM Orders o INNER JOIN Items i ON o.item_id = i.item_id
GROUP BY i.item_category;

---------------------------------------------------------------------------------------------------------------------
# Q.7 Write an SQL query to find employees who earn the top three salaries in each of the department. 
# For the above tables, your SQL query should return the following rows (order of rows does not matter).
select*from employee1;
select*from department;

with ct as (select d.name as department ,e.name as employee,e.salary,dense_rank()over(partition by d.name order by e.salary desc)as s
from employee1 e join  department d on e.departmentid=d.id)
select *
from ct
where s<=3;












  