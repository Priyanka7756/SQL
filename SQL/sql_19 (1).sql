select * from purches
select *from location1
select * from stage
select * from user
select *from items
select*from purches_s
select *from purches_d
# 1. Get me a list of all purchases made between two dates (arbitrary)
select *
from purches
where timestamp between '2012-07-01' AND '2012-12-31';

# 2.
select p.contract_no,p.user_id,sum(i.price*d.quantity)
from purches p join items i on p.user_id=i.id  join purches_d  d on i.id=d.item_id 
where p.timestamp between '2012-07-01' AND '2012-12-31'
group by p.timestamp ;

#2..Get me a total of all purchases made between two dates (arbitrary) that were authorized by Bob, grouped by location 
select u.login_name,p.location_id,sum(d.price*d.quantity)
from purches p join user u on  p.user_id=u.id join purches_d d on p.contract_no=d.contract_no join location1 l on p.location_id=l.id
where u.login_name='bob' and timestamp between '2012-07-01' AND '2012-12-31'
group by p.location_id
# 3.Get me an average of how long it takes each user to Submit and Authorize purchases.
select avg(

# 4. Get me a list of all purchases that sold at least 5 of something (arbitrary) and have been Submitted or Authorized by Bob.
