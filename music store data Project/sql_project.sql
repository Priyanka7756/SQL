
/*           SQL PROJECT- MUSIC STORE DATA ANALYSIS      */
/*           Project Phase I                             */
/* 1. Who is the senior most employee based on job title? */

select *from employee               -- according to level column 
select title,first_name,last_name
from employee
order by levels desc
limit 1;

/* 2. Which countries have the most Invoices?*/
select*from invoice;

select distinct  billing_country,count(*)  -- count the invoices according to country 
from invoice 
group by billing_country
order by count(*) desc
limit 1;

-- 2nd apporch - using join 
select a.country,count(a.country)
from customer a join invoice b on a.customer_id=b.customer_id
group by a.country
order by count(a.country) desc

/* 3. What are top 3 values of total invoice?  */
select*from invoice;
SELECT total 
FROM invoice
ORDER BY total DESC;

-- 2nd apporch- Using cte
with ct as (select total,dense_rank()over(order by total desc) as rnk
from invoice) 
select * from ct
where rnk<=3

/*  4. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money.
 Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select billing_city,sum(total)
from invoice
group by billing_city
order by sum(total) desc
limit 1;

-- 2nd apporch - using join
select a.city,sum(b.total)
from customer a join invoice b on a.customer_id=b.customer_id
group by a.city
order by sum(b.total) desc
limit 1;


/* 5. Who is the best customer? The customer who has spent the most money will be declared the best customer.
Write a query that returns the person who has spent the most money */
select a.customer_id,a.first_name,a.last_name,sum(b.total)
from customer a join invoice b on a.customer_id=b.customer_id
group by a.customer_id
order by sum(b.total) desc
limit 1;

                  /*      Project Phase II      */
/* 1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A  */
select*from genre
select *from customer

select distinct a.email,a.first_name,a.last_name,e.name        -- join releted table and find customer name with where genre name rock 
from  customer a join invoice b on a.customer_id=b.customer_id
join invoice_line c on b.invoice_id=c.invoice_id
join track1 d on c.track_id=d.track_id
join genre e on d.genre_id=e.genre_id
where  e.name like 'rock'
order by a.email ;

/* 2nd apporch    - subquery */  
select distinct a.email,a.first_name,a.last_name
from  customer a join invoice b on a.customer_id=b.customer_id
join invoice_line c on b.invoice_id=c.invoice_id
where track_id in (select track_id from track1 d join genre e on d.genre_id=e.genre_id
where e.name like 'rock')
order by a.email 


/* 2. Let's invite the artists who have written the most rock music in our dataset.
 Write a query that returns the Artist name and total track count of the top 10 rock bands */

  select c.artist_id,c.name,count(c.artist_id),d.name
 from track1 a join album1 b on a.album_id=b.album_id
 join artist c on b.artist_id=c.artist_id
 join genre d on a.genre_id=d.genre_id
 where d.name like 'rock'
 group by c.artist_id
 order by count(c.artist_id) desc
 limit 10;
 
  select c.artist_id,c.name,count(a.name),d.name
 from track1 a join album1 b on a.album_id=b.album_id
 join artist c on b.artist_id=c.artist_id
 join genre d on a.genre_id=d.genre_id
 where d.name like 'rock'
 group by c.name
 order by  count(a.name) desc
 limit 10;
 
 
 /* 3. Return all the track names that have a song length longer than the average song length.
 Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.*/

 SELECT name,miliseconds
FROM track
WHERE miliseconds > (
	SELECT AVG(miliseconds) AS avg_track_length
	FROM track1 )
ORDER BY miliseconds DESC;

--  2nd apporch -with CTE 
with ct as (select  name,avg(milliseconds) as avg1 from track1)
select name,milliseconds 
from track1 
where milliseconds>(select avg1 from ct )
order by milliseconds desc

                                      /*      project Phase -3       */
/* 1. Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */
WITH ct AS (SELECT artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
FROM invoice_line
JOIN track1 ON track1.track_id = invoice_line.track_id
JOIN album1 ON album1.album_id = track1.album_id
JOIN artist ON artist.artist_id = album1.artist_id
GROUP BY artist.artist_id
ORDER BY 3 DESC
LIMIT 1)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track1 t ON t.track_id = il.track_id
JOIN album1 alb ON alb.album_id = t.album_id
JOIN ct bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;


/* 2. We want to find out the most popular music Genre for each country.
 We determine the most popular genre as the genre with the highest amount of purchases.
 Write a query that returns each country along with the top Genre.
 For countries where the maximum number of purchases is shared return all Genres */

 WITH ct AS (SELECT COUNT(il.quantity) AS purchases, c.country, g.name, g.genre_id, 
ROW_NUMBER() OVER(PARTITION BY c.country ORDER BY COUNT(il.quantity) DESC) AS RowNo 
FROM invoice_line il
JOIN invoice i ON i.invoice_id = il.invoice_id
JOIN customer c ON c.customer_id = i.customer_id
JOIN track1 t ON t.track_id = il.track_id
JOIN genre g ON g.genre_id = t.genre_id
GROUP BY 2,3,4
ORDER BY 2 ASC, 1 DESC)
SELECT * FROM ct WHERE RowNo <= 1

-- 2nd  approch -wihout cte  
 select e.name,e.genre_id,a.country,count(c.quantity) as  purchase,row_number()over( partition by a.country order by count(c.quantity) desc) rnk
 from customer a join invoice b on a.customer_id=b.customer_id
 join invoice_line c on b.invoice_id=c.invoice_id
 join track1 d on c.track_id=d.track_id
 join genre e on d.genre_id=e.genre_id
 group by a.country,e.name,e.genre_id
 order by  a.country,count(c.quantity) desc;
 
 
 /* 3. Write a query that determines the customer that has spent the most on music for each country. 
 Write a query that returns the country along with the top customer and how much they spent. 
 For countries where the top amount spent is shared, provide all customers who spent this amount. */
 
 -- answer - using ct create temp table and use row_number for each country wise rank .
 WITH Ct AS (SELECT c.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
row_number() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
GROUP BY 1,2,3,4
ORDER BY billing_country asc, 5 DESC)

SELECT * FROM Ct WHERE RowNo <= 1
 
 /*   2nd apporch -wihout cte    */
 select  c.customer_id,c.first_name,c.last_name,i.billing_country,sum(i.total),dense_rank()over(partition by i.billing_country order by sum(total) desc)
 from customer c join invoice i on c.customer_id=i.customer_id
 group by 1,2,3,4
 order by sum(i.total) desc

/* dense_rank*/
WITH Ct AS (SELECT c.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
dense_rank() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
GROUP BY 1,2,3,4
ORDER BY billing_country asc, 5 DESC)

SELECT * FROM Ct WHERE RowNo <= 1;









