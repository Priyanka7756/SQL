/*. From the following tables write a SQL query to find the salesperson and customer who reside in the same city. Return Salesman, cust_name and city. */
select* from customer;
select* from salesman;
select*from orders;

select s.name as salesman_name,c.cust_name,s.city,c.city
from customer c join salesman s on c.saleman_id=s.salesman_id
where s.city=c.city


/* 2. From the following tables write a SQL query to find those orders where the order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city*/
select o.ord_no,o.puch_amt,c.cust_name,c.city
from orders o left join customer c on c.customer_id=o.customer_id
where o.puch_amt between 500 and 2000;


/*Q3.From the Customer & salesman table above, write a SQL query to find the salesperson(s) and the customer(s) he represents. Return Customer Name, city, Salesman, commission*/
select c.cust_name,s.salesman_id as saleman,s.commission,s.city as salecity
from customer c right join salesman s on c.saleman_id=s.salesman_id;

/*Q4.From the Customer & salesman table above,  write a SQL query to find salespeople who received commissions of more than 12 percent from the company. Return Customer Name, customer city, Salesman, commission*/
select c.cust_name,c.city,s.name as saleman, concat(round(s.commission*100 ),'%')as percent
from customer c right join salesman s on c.saleman_id=s.salesman_id
having percent>12;

/*Q5. From the Customer & salesman table above, write a SQL query to locate those salespeople who do not live in the same city where their customers live and have received a commission of more than 12% from the company. Return Customer Name, customer city, Salesman, salesman city, commission. */
select c.city, c.cust_name,s.name as saleman,s.city as salecity,commission,concat(round(s.commission*100),'%')as percent
from customer c left join salesman s on c.saleman_id=s.salesman_id
group by s.city
having percent >12;

/*Q6. From the orders, salesman and customer table above, write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission. */
select o.ord_no,o.ord_date,o.puch_amt,c.cust_name,c.grade,s.name as saleman
from customer c inner join orders o on c.customer_id=o.customer_id inner join salesman s on s.salesman_id=o.salesman_id;

/*Q7. Write a SQL statement to join the tables salesman, customer and orders so that the same column of each table appears once and only the relational rows are returned*/
select * from customer c  join orders o on c.customer_id=o.customer_id  join salesman s on s.salesman_id=o.salesman_id;


select* from salesman
natural join orders
natural join customer;
select c.saleman_id,s.salesman_id,o.salesman_id
from customer c 
join salesman s
using(city)
join orders o
using(salesman_id)

