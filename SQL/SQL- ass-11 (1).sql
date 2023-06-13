/* Table Scripts: 
create table mountain_huts ( id integer not null, name varchar(40) not null, altitude integer not null, unique(name) , unique(id) ); 
create table trails ( hut1 integer not null, hut2 integer not null ); 
insert into mountain_huts values (1,'Dakonat',1900) ,(2,'Natisa',2100) ,(3,'Gajantut',1600) ,(4,'Rifat',782) ,(5,'tupur',1370) ; insert into trails values (1,3) ,(3,2) ,(3,5) ,(4,5) ,(1,5);

Question:
A ski company is planning to construct a new ski slope using a pre-existing network of mountain huts and trails between them. A new slope has to begin at one of the mountain huts, have a middle station at another hut connected with the first one by a direct trail, and end at the third mountain hut which is also connected by a direct trail to the second hut. The altitude of the three huts chosen for constructing the ski slope has to be strictly decreasing. 
You are given two SQL tables, mountain_huts and trails, with the following structure each entry table trails represents a direct connection between huts with IDs hut1 and hut2. 
Note that all trails are bidirectional. 
Create a query that finds all triplets(startpt, middlept, endpt) representing that mountain huts that may be used for construction of a ski slope. Output returned by the query can be ordered in any way.
*/

select*from mountain_huts;
select*from trails;

with ct as (select b.name as hut1_name,c.name as hut2_name,b.altitude as h1_alt,c.altitude as h2_alt
from trails  a
 left join mountain_huts  b on a.hut1=b.id
 left join mountain_huts c on a.hut2=c.id),
 c2 as (select * from ct 
 where h1_alt>h2_alt
 union all 
 select hut2_name,hut1_name,h2_alt,h1_alt
 from ct
 where h1_alt<h2_alt)
 select d.hut1_name,d.hut2_name,e.hut2_name
 from c2 d inner join c2 e on d.hut2_name=e.hut1_name;






SELECT h1.id AS startpt, h2.id AS middlept, h3.id AS endpt
FROM mountain_huts h1
JOIN trails t1 ON h1.id = t1.hut1
JOIN mountain_huts h2 ON t1.hut2 = h2.id AND h2.altitude < h1.altitude
JOIN trails t2 ON h2.id = t2.hut1
JOIN mountain_huts h3 ON t2.hut2 = h3.id AND h3.altitude < h2.altitude
ORDER BY h1.id, h2.id, h3.id;


