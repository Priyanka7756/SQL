
select*from smart_phone;

/*1. Find top 5 samsung phones with biggest screen size */
select brand_name,screen_size
from smart_phone
where lower(brand_name='samsung')
order by screen_size desc
limit 5;

/* with window function*/
select distinct(screen_size),dense_rank()over(order by screen_size desc) 
from smart_phone
where brand_name='samsung'
limit 5;

select brand_name,max(screen_size) from smart_phone
where brand_name='samsung'and screen_size<>(select max(screen_size) from smartphones1  order by screen_size desc)

/*2. Sort all the phone in decending oder of number of total cameras */
select brand_name,sum(num_rear_cameras)+sum(num_front_cameras)+sum(primary_camera_rear)+sum(primary_camera_front) as total
from smart_phone
group by brand_name
order by total desc

select brand_name,sum(num_rear_cameras)as a,sum(num_front_cameras)as b,sum(primary_camera_rear)as c,sum(primary_camera_front) as d
from smart_phone
group by brand_name
order by a desc,b desc,c desc,d desc



/* 3. Sort data on the basis of ppi in decreasing order */
select*from smart_phone
order by price desc

/*4. Find the phone with second largest battery */

select brand_name,battery_capacity
from smart_phone
order by battery_capacity desc;
limit 1,1;

/* with subquery*/
select brand_name,max(battery_capacity)
from smart_phone
where battery_capacity<>(select max(battery_capacity)from smartphones1)

/*5. Find the name and rating of the worst rated apple phone*/
select brand_name,rating,model
from smart_phone
where brand_name='apple' and rating<7
group by rating
order by rating desc;

/*6. Group smartphones by brand and get the count , average price , max rating , avg screen size and avg battery capacity*/
select brand_name,count(distinct brand_name),avg(price),max(rating),avg(screen_size),avg(battery_capacity)
from smart_phone
group by brand_name;

/* 7. Find top 5 most costly phone brands*/
select brand_name,price from smart_phone
order by price desc
limit 5

/* 8. Avg price of 5G phones vs avg price of non 5G phones*/
select avg(price),has_5g
from smart_phone 
group by has_5g ;

/* 9. Which brand makes the smallest screen smartphones*/
select brand_name,min(screen_size)
from smart_phone
order by screen_size 

/* 10. Find the avg rating of smartphones brands which have more than 20 phones*/
select brand_name,count(brand_name),avg(rating)
from smart_phone
group by brand_name
having count(brand_name)>20;
