create table customer_orders ( order_id integer, customer_id integer, order_date date, order_amount  integer) 
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100) ,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700) ,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000) ;

/* --Question-1
1.Repeat Customers problem
--Count of new and repeat customers by date
--Date, new_cust_count, repeat_cust_count */

select * from customer_orders
with ct as (select customer_id, min(order_date) as first_visit_date
from customer_orders
group by customer_id)
select order_date,sum(case when order_date=first_visit_date then 1 else 0 end )as new_customer,
sum(case when order_date>first_visit_date then 1 else 0 end) as repeat_customer
from customer_orders a inner join ct b on a.customer_id=b.customer_id
group by order_date


/*2.Uber Trip cancellation rate*/
Create table Trips (id int, client_id int, driver_id int, city_id int, status varchar(50), request_at varchar(50));
Create table Users (users_id int, banned varchar(50), role varchar(50));  

insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01'); 
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02'); 
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03');

insert into Users (users_id, banned, role) values ('1', 'No', 'client'); 
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client'); 
insert into Users (users_id, banned, role) values ('3', 'No', 'client'); 
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver'); 

select* from trips;
select *from users;

/*-- Question -2
-Cancellation rate for unbanned users by date 
--No of rides cancelled for unbanned users/total no. of rides requested for unbanned users 
--Date, cancelled_trip count, total_rides, cancellation_rate
--cancellation rate = cancelled trip count/total_rides * 100. */

select request_at,sum(case when status in ("cancelled_by_driver","cancelled_by_client")then 1 else 0 end)as count_cancelled_trip,
count(1),100*sum(case when status in ("cancelled_by_driver","cancelled_by_client")then 1 else 0 end) /count(1) as cancellation_rate
from trips a inner join users b on a.client_id=b.users_id
inner join users c on  a.driver_id=c.users_id
where lower(b.banned="No") and lower(c.banned="No" )
group by request_at ;
