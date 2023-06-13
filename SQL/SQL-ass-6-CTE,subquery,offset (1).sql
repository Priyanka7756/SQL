
CREATE TABLE emp1
   (
    EMPNO INT PRIMARY KEY, 
	ENAME VARCHAR(10), 
	JOB VARCHAR(9), 
	MGR INT, 
	HIREDATE DATE, 
	SAL INT, 
	DEPTNO INT
   ) ;
   
   SELECT * FROM emp1;
   
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7839,'KING','PRESIDENT',null,STR_TO_DATE('17-11-81', '%d-%m-%y'),5000,10);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7698,'BLAKE','MANAGER',7839,str_to_date('01-05-81','%d-%m-%y'),2850,30);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7782,'CLARK','MANAGER',7839,STR_TO_DATE('09-06-81','%d-%m-%y'),2450,10);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7566,'JONES','MANAGER',7839,STR_TO_DATE('02-04-81','%d-%m-%y'),2975,20);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7788,'SCOTT','ANALYST',7566,STR_TO_DATE('19-04-87','%d-%m-%y'),3000,20);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7902,'FORD','ANALYST',7566,STR_TO_DATE('03-12-81','%d-%m-%y'),3000,20);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7369,'SMITH','CLERK',7902,STR_TO_DATE('17-12-80','%d-%m-%y'),50,20);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7499,'ALLEN','SALESMAN',7698,STR_TO_DATE('20-02-81','%d-%m-%y'),1600,30);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7521,'WARD','SALESMAN',7698,STR_TO_DATE('22-02-81','%d-%m-%y'),1250,30);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7654,'MARTIN','SALESMAN',7698,STR_TO_DATE('28-09-81','%d-%m-%y'),1250,30);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7844,'TURNER','SALESMAN',7698,STR_TO_DATE('08-09-81','%d-%m-%y'),1500,30);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7876,'ADAMS','CLERK',7788,STR_TO_DATE('23-05-87','%d-%m-%y'),1100,20);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7900,'JAMES','CLERK',7698,STR_TO_DATE('03-12-81','%d-%m-%y'),8005,30);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (7934,'MILLER','CLERK',7782,STR_TO_DATE('23-01-82','%d-%m-%y'),1300,40);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (8001,'ANABELLE','CLERK',7698,STR_TO_DATE('03-12-81','%d-%m-%y'),5500,20);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (8002,'OLIVE','CLERK',7698,STR_TO_DATE('03-12-81','%d-%m-%y'),5800,20);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (8003,'OLIVE','CLERK',7698,STR_TO_DATE('03-12-81','%d-%m-%y'),5800,20);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (8004,'KINGS','CLERK',7698,STR_TO_DATE('03-12-81','%d-%m-%y'),5800,20);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (8005,'KINE','CLERK',7698,STR_TO_DATE('03-12-81','%d-%m-%y'),5800,20);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (8006,'KILLEY','SALESMAN',7788,STR_TO_DATE('12-06-90','%d-%m-%y'),7500,null);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (8007,'Jason','developer',7788,STR_TO_DATE('12-06-90','%d-%m-%y'),7500,null);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (8008,'BIPLAB  ','CLERK',7788,STR_TO_DATE('12-07-89','%d-%m-%y'),8999,20);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (8009,'BIPLAB','SALESMAN',7698,STR_TO_DATE('12-03-22','%d-%m-%y'),9000,30);
Insert into emp1 (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO) values (8010,'Jason','SALESMAN',7698,STR_TO_DATE('12-03-22','%d-%m-%y'),9000,30);


/*--Assignment
--Find all employees with 4th highest salary
--Use subquery or CTE along with Offset,limit, ranking window function */

/* 1st solution- using limit*/ --- /*in mysql OFFSET not works*/
select ename,sal from emp1
order by sal desc
limit 4,1

/* with CTE */
with ct as (select ename, sal,dense_rank()over(order by sal desc) as highest_sal from emp1)
select ename,sal from ct where highest_sal=4;

/* using subquery*/

select ename,max(sal) from emp1
where sal<(select max(sal) from emp1 where sal<(select max(sal)from emp1 where sal<(select max(sal)
from emp1 )));
