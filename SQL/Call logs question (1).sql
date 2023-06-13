create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');
	   
	   
--Write a sql query to find ut callers whose first and last call was with the same person on a given day


select* from phonelog

with ct as (select callerid,recipientid,date(datecalled) as date1 , rank()over() (partition by callerid,date(datecalled) order by datecalled) rnk
from phonelog),
ct2 as (select callerid,recipientid,date(datecalled) as date1 ,rank()over() (partition by callerid,date(datecalled) order by datecalled desc) rnk2 
from phonelog)
select a.callerid,a.recipientid,a.date
from ct a inner join ct2 b on a.callerid=b.callerid and a.recipientid=b.recipientid and a.date1=b.date1
where rnk=1 and rnk2=1;