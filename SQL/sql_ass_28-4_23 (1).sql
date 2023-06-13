select *from airnb
#1. top neighbourhoods in NYC  with respect to average price/day airnb listing?
select neighbourhood,avg(price/minimum_nights)
from airnb
group by neighbourhood

# 2.room_type vs price on different neighbourhood groups
select neighbourhood,room_type,price
from airnb
group by neighbourhood

# 3.on an average for how many nights people stayed in each room_type?
select room_type,avg(minimum_nights)
from airnb
group by room_type

# 4.how monthly reviews varies with room types in each neighbourhd groups?
select neighbourhood, room_type,reviews_per_month
from airnb
group by  neighbourhood,room_type

# 5.top 10 reviewed host on the basis in each neighbourhood groups
select host_name,neighbourhood,count(number_of_reviews) cnt
from airnb
group by neighbourhood
order by cnt  desc
# 6.room_types and their relation with availability in different neighbourhood groups?
select room_type,neighbourhood_group,availability_365
from airnb
group by neighbourhood_group, room_type
# 7.explore relationship between the locations and neighborhoods
select neighbourhood_group,neighbourhood,count(*)
from airnb
group by neighbourhood_group,neighbourhood
order by neighbourhood_group,neighbourhood







