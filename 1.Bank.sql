CREATE TABLE BRANCH(
BRANCH_ID VARCHAR(10),
BANK_NAME VARCHAR(15),
BRANCH_NAME VARCHAR(20),
ASSETS INT NOT NULL,
PRIMARY KEY(BRANCH_ID));


CREATE TABLE CUSTOMER(
CUSTOMER_ID VARCHAR(10),
CUSTOMER_NAME VARCHAR(20),
CUSTOMER_AGE INT,
CUSTOMER_ADDRESS VARCHAR(20),
CUSTOMER_PHONE INT,
PRIMARY KEY(CUSTOMER_ID));


CREATE TABLE ACCOUNT(
ACC_NO INT,
BRANCH_ID VARCHAR(10),
ACCOUNT_TYPE VARCHAR(10),
ACCOUNT_BALANCE INT,
CUSTOMER_ID VARCHAR(10),
PRIMARY KEY(ACC_NO),
FOREIGN KEY (BRANCH_ID) REFERENCES BRANCH(BRANCH_ID) ON DELETE CASCADE,
FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID) ON DELETE CASCADE );


CREATE TABLE LOAN(
LOAN_NUMBER VARCHAR(5),
BRANCH_ID VARCHAR(10),
AMOUNT INT,
CUSTOMER_ID VARCHAR(10), 
PRIMARY KEY(LOAN_NUMBER),
FOREIGN KEY (BRANCH_ID) REFERENCES BRANCH(BRANCH_ID) ON DELETE CASCADE,
FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID) ON DELETE CASCADE);

INSERT INTO BRANCH VALUES('B1','CANARA','MANGALURU',60000000);
INSERT INTO BRANCH VALUES('B2','BANK OF BARODA','MANGALURU',70000000);
INSERT INTO BRANCH VALUES('B3','CANARA','KASARAGOD',50000000);
INSERT INTO BRANCH VALUES('B4','SBI','BENGALURU',30000000);
INSERT INTO BRANCH VALUES('B5','UNION BANK','DELHI',20000000);


INSERT INTO CUSTOMER VALUES('C1','RAVI',22,'MANGALURU',8745263);
INSERT INTO CUSTOMER VALUES('C2','ASHA',26,'DELHI',98745641);
INSERT INTO CUSTOMER VALUES('C3','VARUN',23,'KASARAGOD',78954628);
INSERT INTO CUSTOMER VALUES('C4','ARPITHA',22,'MANGALURU',9856325);
INSERT INTO CUSTOMER VALUES('C5','SACHIN',23,'BENGALURU',78541365);


INSERT INTO ACCOUNT VALUES(123,'B1','SAVINGS',10000,'C1');
INSERT INTO ACCOUNT VALUES(456,'B5','RECURRING',20000,'C2');
INSERT INTO ACCOUNT VALUES(789,'B1','SAVINGS',30000,'C1');
INSERT INTO ACCOUNT VALUES(1122,'B2','FD',50000,'C3');
INSERT INTO ACCOUNT VALUES(1334,'B','SAVINGS',10000,'C4');
INSERT INTO ACCOUNT VALUES(1234,'B3','FD',90000,'C5');
INSERT INTO ACCOUNT VALUES(5876,'B4','RECURRING',80000,'C3');


INSERT INTO LOAN VALUES('L1','B1',500000,'C1');
INSERT INTO LOAN VALUES('L2','B2',50000,'C2');
INSERT INTO LOAN VALUES('L3','B3',40000,'C3');
INSERT INTO LOAN VALUES('L4','B2',565000,'C4');
INSERT INTO LOAN VALUES('L5','B4',955000,'C5');
INSERT INTO LOAN VALUES('L6','B5',20000,'C2');

==============================================================

1)
SELECT C.CUSTOMER_ID,C.CUSTOMER_NAME FROM CUSTOMER C,ACCOUNT A,BRANCH B
WHERE B.BRANCH_NAME='MANGALURU'AND B.BRANCH_ID=A.BRANCH_ID 
AND A.CUSTOMER_ID=C.CUSTOMER_ID;

2)
SELECT C.CUSTOMER_ID,C.CUSTOMER_NAME,A.ACCOUNT_BALANCE FROM 
CUSTOMER C,ACCOUNT A
WHERE C.CUSTOMER_ID=A.CUSTOMER_ID AND 
ACCOUNT_BALANCE=(SELECT MAX(ACCOUNT_BALANCE)FROM ACCOUNT);

3)
SELECT C.CUSTOMER_NAME C,L.AMOUNT FROM CUSTOMER C,LOAN L 
WHERE C.CUSTOMER_ID=L.CUSTOMER_ID AND AMOUNT>500000;

4)
SELECT BANK_NAME,BRANCH_NAME,ASSETS FROM BRANCH 
WHERE ASSETS=(SELECT MAX(ASSETS)FROM BRANCH)
UNION 
SELECT BANK_NAME,BRANCH_NAME,ASSETS FROM BRANCH  
WHERE ASSETS=(SELECT MIN(ASSETS)FROM BRANCH);

5)
DELETE FROM BRANCH WHERE BRANCH_NAME='DELHI';

============================================================
