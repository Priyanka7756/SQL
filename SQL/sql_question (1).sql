# creat computer table
CREATE TABLE COMPUTER (
COMPID int  PRIMARY KEY,
BRAND VARCHAR(50),
COMPMODEL VARCHAR(50),
MANUFACTUREDATE DATE);

# Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
EMPID int ,
FIRSTNAME VARCHAR(50),
LASTNAME VARCHAR(50),
SALARY int ,
EMAILID VARCHAR (50),
MANAGERID int ,
DATEOFJOINING DATE,
DEPT VARCHAR (10),
COMPID int);

# Insert data into COMPUTER table
INSERT INTO COMPUTER VALUES (1001,'Lenovo','T480','19-06-12');  
INSERT INTO COMPUTER VALUES (1002,'Lenovo','T490','20-08-24'); 
INSERT INTO COMPUTER VALUES (1003,'SONY','SQ112','19-12-01'); 
INSERT INTO COMPUTER VALUES (1004,'SONY','SX1001','20-12-20'); 

#Insert data into EMPLOYEE table

INSERT INTO EMPLOYEE VALUES (1,'NANDA','KUMAR',50000, 'NANDA@GMAIL.COM',NULL,                             
'12-06-15','IT',1001);

INSERT INTO EMPLOYEE VALUES (2,'BIPLAB','PARIDA',30000, 'BPARIDA@YAHOO.COM',1,
'15-12-21','IT',1001);

INSERT INTO EMPLOYEE VALUES (3,'DISHA','PATEL',50000,'DISHAP@GMAIL.COM',NULL,
'13-08-21','HR',NULL);

INSERT INTO EMPLOYEE VALUES (4,'SIBA','PRASAD',90000,'SIBA@GMAIL.COM',3,
'20-06-01','HR',1002);

INSERT INTO EMPLOYEE VALUES (5,'ANUSHKA','SHARMA', 20000, 'SHARMAA@GMAIL.COM',1,
'21-04-01','IT', NULL);
INSERT INTO EMPLOYEE VALUES (6,'SOMNATH','MAHARANA', 65000, 'SMAHA@GMAIL.COM',3,
'19-05-07','IT',1003);


# 1.SQL Query to update DateOfJoining to 2012-08-15 for empid =1.
# 2.SQL Query to select all student name where age is greater than 22?

 # 3.SQL Query to Find all employee with Salary between 40000 and 80000?
 
 # 4.Query to fetch details of employees not having computer?
 # 5.Fetch all Computer Details along with employee name using it ?
 # 6. Write an SQL query to fetch the employee FIRST names and replace the A with '@'
 # 7. Find the first employee and last employee from employee table?
 # 8.Retrieve the employees and their respective managers' details, including those who do not have a manager.
 # 9.Find the employees who have the same salary as their managers.
 # 10. Write an SQL query to fetch the first 50% records from a table:
 
 

