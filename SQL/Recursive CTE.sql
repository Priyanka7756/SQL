--Recursive CTE

create table sales (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);

SELECT CAST((period_start + INTERVAL '1 day') AS DATE)
FROM sales

--Recursive CTE
--print numbers from 1-10

with recursive cte_num as
( SELECT 1 as num
 
 UNION ALL
 
 SELECT num+1
 FROM cte_num
 WHERE num <=10
)
SELECT num
FROM cte_num

--Solution

with RECURSIVE cte AS (
  SELECT min(period_start) as dates, max(period_end) as max_date FROM sales --anchor query
  
  UNION ALL
  
  SELECT CAST((dates + INTERVAL '1 day') AS DATE) as dates, max_date FROM cte --recursive query
  WHERE dates < max_date
  )
  
SELECT product_id, date_part('year',dates) as Year_of_sale, SUM(average_daily_sales) as Total_sales
FROM cte
INNER JOIN sales ON dates between period_start AND period_end
group by product_id, date_part('year',dates)
order by product_id


with RECURSIVE cte AS (
  SELECT min(period_start) as dates, max(period_end) as max_date FROM sales --anchor query
  
  UNION ALL
  
  SELECT CAST((dates + INTERVAL '1 day') AS DATE) as dates, max_date FROM cte --recursive query
  WHERE dates < max_date
  )
  
SELECT *
FROM cte
INNER JOIN sales ON dates between period_start AND period_end
order by product_id, dates


SELECT * FROM sales






