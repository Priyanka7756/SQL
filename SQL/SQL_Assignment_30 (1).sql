select*from ord;
select*from location;

/* Most profitable product region wise.*/
select product_name,sum(profit),region
from ord
group by product_name,region
order by sum(profit) desc
limit 1;

/* Which city has most number of ordered product.*/
select count(a.product_name) as most_ordered,b.city
from ord a inner join location b on a.postal_code=b.postal_code
group by b.city
order by count(a.product_name) desc
limit 1;

/* State wise profits.*/
select sum(a.profit),b.state
from ord a inner join location b on a.postal_code=b.postal_code
group by b.state
order by sum(a.profit) desc;

/* State wise loss.*/
select b.state,sum(profit) as loss
from ord a inner join location b on a.postal_code=b.postal_code
group by b.state
having sum(profit)<1
order by sum(profit)

/* Most loss making segment.*/

select segment,sum(profit) as loss
from ord 
group by segment
having sum(profit)<1
order by sum(profit)
limit 1;

/* Most ordered product in "Texas".*/
select count(a.product_name) as total_orderd,b.state,a.product_name
from ord a inner join location b on a.postal_code=b.postal_code
where lower(b.state='texas')
group by a.product_name
order by count(a.product_name) desc
limit 1;

select count(a.order_id) as total_orderd,b.state,a.product_name
from ord a inner join location b on a.postal_code=b.postal_code
where lower(b.state='texas')
group by a.product_name
order by count(a.order_id) desc;


/* How many product are ordered yearly.*/
select year(order_date),count(order_id),product_name
from ord
group by year(order_date)
order by count(order_id) desc;

/* Least ordered product in "Colorado".*/
select count(a.order_id),b.state,a.order_id,a.product_name
from ord a inner join location b on a.postal_code=b.postal_code
where lower(b.state='Colorado')
group by a.order_id
order by count(a.order_id) asc
limit 1;

/* Which sub category is performing well.*/
select sub_category,sum(profit) as good_performing
from ord
group by sub_category
order by sum(profit) desc;

/* Which month observe highest number of order placed.*/
select month(order_date) as month_ord,count(order_id),product_name
from ord
group by order_id
order by count(order_id) desc;







