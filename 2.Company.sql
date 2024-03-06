CREATE TABLE EMPLOYEE(
EID INT PRIMARY KEY,
NAME VARCHAR2(20),
ADDRESS VARCHAR2(20),
GENDER CHAR(1) CHECK(GENDER='M' OR GENDER='F'),
SALARY NUMBER(6),
SUPEREID REFERENCES EMPLOYEE(EID),
DNO NUMBER);

INSERT INTO EMPLOYEE VALUES(1,'RAHUL','MANGALURU','M',35000,1,NULL);
INSERT INTO EMPLOYEE VALUES(2,'SAHANA','MANGALURU','F',35000,1,NULL);
INSERT INTO EMPLOYEE VALUES(3,'SAGAR','BENGALURU','M',35000,1,NULL);
INSERT INTO EMPLOYEE VALUES(4,'SAGARIK','MANGALURU','M',35000,1,NULL);
INSERT INTO EMPLOYEE VALUES(5,'SAJAAN','MANGALURU','M',600000,1,NULL);


CREATE TABLE DEPARTMENT(
DNUM NUMBER(5) PRIMARY KEY,
DNAME VARCHAR2(10),
DMGR_ID REFERENCES EMPLOYEE(EID),
MGR_START_DATE DATE);

INSERT INTO DEPARTMENT VALUES(1,'CSE',1,'2-NOV-2007');
INSERT INTO DEPARTMENT VALUES(2,'IOT',2,'2-NOV-2007');
INSERT INTO DEPARTMENT VALUES(3,'ACCOUNT',2,'2-NOV-2017');
INSERT INTO DEPARTMENT VALUES(4,'ISE',1,'2-NOV-2000');
INSERT INTO DEPARTMENT VALUES(5,'FINANCE',1,'3-NOV-2001');

ALTER TABLE EMPLOYEE ADD CONSTRAINT FK FOREIGN KEY(DNO) REFERENCES DEPARTMENT(DNUM);


UPDATE EMPLOYEE SET DNO=4 WHERE EID=1;
UPDATE EMPLOYEE SET DNO=1 WHERE EID=2;
UPDATE EMPLOYEE SET DNO=3 WHERE EID=3;
UPDATE EMPLOYEE SET DNO=3 WHERE EID=4;
UPDATE EMPLOYEE SET DNO=3 WHERE EID=5;

CREATE TABLE DLOCATION(
DNO REFERENCES DEPARTMENT(DNUM),
LOCATION VARCHAR(10),
PRIMARY KEY(DNO,LOCATION));

INSERT INTO DLOCATION VALUES(1,'MANGALURU');
INSERT INTO DLOCATION VALUES(1,'MYSORE');
INSERT INTO DLOCATION VALUES(2,'MANGALURU');
INSERT INTO DLOCATION VALUES(3,'BENGALURU');
INSERT INTO DLOCATION VALUES(4,'MANGALURU');
INSERT INTO DLOCATION VALUES(5,'MANGALURU');


CREATE TABLE PROJECT(
PNUM NUMBER(2) PRIMARY KEY,
PNAME VARCHAR2(20),
PLOCATION VARCHAR2(20),
DNO NUMBER REFERENCES DEPARTMENT(DNUM));

INSERT INTO PROJECT VALUES(1,'IOT','MANGALURU',1);
INSERT INTO PROJECT VALUES(2,'DATA MINING','MANGALURU',1);
INSERT INTO PROJECT VALUES(3,'CC','HUBLI',3);
INSERT INTO PROJECT VALUES(4,'IMAGE PROCESSING','MANGALURU',4);
INSERT INTO PROJECT VALUES(5,'RESEARCH','MANGALURU',5);


CREATE TABLE WORKSON(
EID NUMBER(5) REFERENCES EMPLOYEE(EID),
PNO NUMBER(2) REFERENCES PROJECT(PNUM),
HOURS NUMBER(5,2),
PRIMARY KEY(EID,PNO));

INSERT INTO WORKSON VALUES(1,1,4);
INSERT INTO WORKSON VALUES(2,1,5);
INSERT INTO WORKSON VALUES(3,2,4);
INSERT INTO WORKSON VALUES(4,3,4);
INSERT INTO WORKSON VALUES(5,5,4);



CREATE TABLE DEPENDENT(
EMP_ID INT CONSTRAINT DEP_EMPID_PK PRIMARY KEY,
DEPENDENT_NAME VARCHAR2(12),
GENDER VARCHAR(5),
BDATE DATE,
RELATIONSHIP VARCHAR(12),
FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EID) ON DELETE CASCADE);

INSERT INTO DEPENDENT VALUES(1,'SHREYA','F','22-JAN-75','WIFE');
INSERT INTO DEPENDENT VALUES(2,'AKASH','M','15-JUN-77','BROTHER');
INSERT INTO DEPENDENT VALUES(3,'PRIYA','F','10-SEP-80','SISTER');
INSERT INTO DEPENDENT VALUES(4,'NIKHIL','M','02-FEB-79','FATHER');
INSERT INTO DEPENDENT VALUES(5,'AKSHA','F','30-OCT-75','MOTHER');

========================================================================================

1) 
SELECT pno FROM WORKSON WHERE EID IN 
(SELECT Eid FROM EMPLOYEE WHERE NAME='RAHUL') UNION (
SELECT Pnum FROM PROJECT WHERE dno IN (
SELECT Dnum FROM DEPARTMENT WHERE DMGR_ID IN (
SELECT Eid FROM EMPLOYEE WHERE NAME='RAHUL'
))); 


2)
SELECT Eid, name, salary, salary+0.1*salary as updated_salary FROM EMPLOYEE
WHERE Eid IN (SELECT Eid FROM WORKSON WHERE Pno IN(
SELECT Pnum FROM PROJECT WHERE Pname='IOT'
)); 


3)
SELECT SUM(SALARY), AVG(SALARY), MAX(SALARY), MIN(SALARY) FROM EMPLOYEE E, DEPARTMENT D
WHERE D.Dnum=E.Dno AND Dname='ACCOUNT';


4)
SELECT Eid, name FROM EMPLOYEE E WHERE NOT EXISTS(
(SELECT Pnum FROM PROJECT WHERE Dno=5) MINUS (SELECT Pno FROM WORKSON W WHERE W.Eid=E.Eid));

5)
CREATE VIEW DEPTINFO(NAME,COUNT_EMP,SUM_SAL) AS
SELECT D.DNAME,COUNT(*),SUM(SALARY)
FROM DEPARTMENT D INNER JOIN EMPLOYEE E
ON E.DNO=D.DNUM
GROUP BY D.DNAME;

SELECT * FROM DEPTINFO;
