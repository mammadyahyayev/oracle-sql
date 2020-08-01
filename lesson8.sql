--DDL : CREATE , ALTER ,DROP,  ON DELETE CASCADE , ON DELETE SET NULL , CREATE TABLE AS SUBQUERY , SET UNUSED
--WRITE ONLY , READ ONLY , RENAME COLUMN , RENAME TABLE

--WITHOUT CONSTRAINT
CREATE TABLE EMPLOYEE_TEST (
    EMPLOYEE_TEST_ID NUMBER,
    NAME VARCHAR2(100),
    SURNAME VARCHAR(100),
    EMAIL VARCHAR2(100),
    PHONE_NUMBER VARCHAR2(100) ,
    HIRE_DATE DATE,
    JOB_ID NUMBER,
    SALARY FLOAT ,
    COMMISSION_PCT FLOAT,
    MANAGER_ID NUMBER ,
     DEPARTMENT_ID NUMBER
);

--WITH CONSTRAINT : COLUMN LEVEL CONSTRAINT
CREATE TABLE JOB_TEST(
    JOB_ID NUMBER CONSTRAINT JOB_ID_TEST_PK PRIMARY KEY,
    JOB_NAME VARCHAR2(100) CONSTRAINT JOB_NAME__TEST_UK UNIQUE,
    JOB_SALARY NUMBER(8,2) ,
    JOB_CREATED_DATE  DATE DEFAULT SYSDATE ,
    ACTIVE NUMBER(1) DEFAULT 1 CONSTRAINT ACTIVE_CHECK CHECK ( ACTIVE IN (1,0)) 
);



--WITH CONSTRAINT TABLE LEVEL CONSTRAINT
CREATE TABLE MANAGER_TEST(
    MANAGER_ID NUMBER,
    MANAGER_NAME VARCHAR2(100),
    MANAGER_SURNAME VARCHAR2(100),
    MANAGER_EXPERIENCE NUMBER,
    ACTIVE CHAR(1) DEFAULT 1,
    CONSTRAINT MANAGER_ID_TEST_PK PRIMARY KEY(MANAGER_ID),  --PRIMARY
    CONSTRAINT MANAGER_SURNAME_TEST_UK UNIQUE(MANAGER_SURNAME), -- UNIQUE
    CONSTRAINT MANAGER_TEST_ACTIVE_CHECK CHECK (ACTIVE IN (1,0)) -- CHECK
);

--CONSTRAINT FOR FOREIGN KEY
CREATE TABLE JOB_TEST_FOR_FK (
JOB_TEST_ID NUMBER,
JOB_NAME VARCHAR2(100),
JOB_SALARY NUMBER(8,2) NOT NULL,
JOB_CREATED_DATE DATE  DEFAULT SYSDATE,
ACTIVE NUMBER(1) DEFAULT 1,
MANAGER_ID NUMBER,
CONSTRAINT JOB_TEST_ID_FK_FOR_PK PRIMARY KEY(JOB_TEST_ID),
CONSTRAINT JOB_NAME_FOR_FK_UK UNIQUE (JOB_NAME),
CONSTRAINT JOB_TEST_FOR_FK_ACTIVE_CHECK CHECK (ACTIVE IN (1,0)),
CONSTRAINT MANAGER_ID_FK FOREIGN KEY(MANAGER_ID) REFERENCES MANAGER_TEST ( MANAGER_ID)
);

--on delete cascade and On delete set null

CREATE TABLE STUDENT(
ID NUMBER PRIMARY KEY,
NAME VARCHAR2(30) ,
SURNAME VARCHAR2(30) NOT NULL,
EMAIL VARCHAR2(40) UNIQUE,
ADDRESS_ID NUMBER,
CONSTRAINT ADDRESS_ID_FK FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESS (ID) ON DELETE CASCADE
);

-- WHEN I DELETE ANY ADDRESS , AND ALSO STUDENT WILL BE DELETED 

CREATE TABLE ADDRESS(
ID NUMBER PRIMARY KEY,
COUNTRY VARCHAR2(50),
CITY VARCHAR2(50),
STREET VARCHAR2(50),
POSTAL_CODE NUMBER,
ACTIVE NUMBER(1) DEFAULT 1
CONSTRAINT ADDRESS_ACTIVE_CHECK CHECK(ACTIVE IN (1 , 0))
);

-- ADD DATA 
INSERT INTO  ADDRESS (ID , COUNTRY , CITY ,STREET , POSTAL_CODE)
VALUES(1,'TURKEY','ANKARA','A.ALI',12789654);

INSERT INTO STUDENT(ID , NAME ,SURNAME , EMAIL , ADDRESS_ID)
VALUES (1 , 'SAMIR' , 'ALIYEV' , 'samir@gmail.com' , 1);

--DELETE ADDRESS
DELETE FROM ADDRESS WHERE ID = 1;

--ON DELETE SET NULL
CREATE TABLE STUDENT(
ID NUMBER PRIMARY KEY,
NAME VARCHAR2(30) ,
SURNAME VARCHAR2(30) NOT NULL,
EMAIL VARCHAR2(40) UNIQUE,
ADDRESS_ID NUMBER,
CONSTRAINT ADDRESS_ID_FK FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESS (ID) ON DELETE SET NULL
);

-- WHEN I DELETE ANY ADDRESS , AND ALSO STUDENT'S ADDRESS_ID COLUMN WILL BE NULL 

CREATE TABLE ADDRESS(
ID NUMBER PRIMARY KEY,
COUNTRY VARCHAR2(50),
CITY VARCHAR2(50),
STREET VARCHAR2(50),
POSTAL_CODE NUMBER,
ACTIVE NUMBER(1) DEFAULT 1
CONSTRAINT ADDRESS_ACTIVE_CHECK CHECK(ACTIVE IN (1 , 0))
);

--ADD DATA
INSERT INTO  ADDRESS (ID , COUNTRY , CITY ,STREET , POSTAL_CODE)
VALUES(1,'TURKEY','ANKARA','A.ALI',12789654);

INSERT INTO STUDENT(ID , NAME ,SURNAME , EMAIL , ADDRESS_ID)
VALUES (1 , 'SAMIR' , 'ALIYEV' , 'samir@gmail.com' , 1);

DELETE FROM ADDRESS WHERE ID = 1;


--CREATE TABLE AS SUBQUERY
CREATE TABLE EMPLOYEE_SUBQUEY_TEST
AS SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , EMAIL ,SALARY FROM EMPLOYEES;

SELECT * FROM EMPLOYEE_SUBQUEY_TEST;

CREATE TABLE EMPLOYEE_SUBQUEY_TEST_2(ID , NAME , SURNAME , EMAIL , SALARY)
AS SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , EMAIL ,SALARY FROM EMPLOYEES;

SELECT * FROM EMPLOYEE_SUBQUEY_TEST_1;



--ALTER(ADD COLUMN)
ALTER TABLE EMPLOYEE_SUBQUEY_TEST_1
ADD 
    ACTIVE NUMBER(1) DEFAULT 1 CONSTRAINT EMPLOYEE_TEST_1_ACTIVE_CHECK CHECK(ACTIVE IN (1,0));


--ALTER TABLE (MODIFY COLUMN)
ALTER TABLE EMPLOYEE_SUBQUEY_TEST_1
MODIFY 
    ID NUMBER;

ALTER TABLE EMPLOYEE_SUBQUEY_TEST_1
MODIFY 
    NAME VARCHAR2(200);


--ALTER TABLE DROP COLUMNS
ALTER TABLE EMPLOYEE_SUBQUEY_TEST_1
DROP COLUMN ACTIVE;


--SET UNUSED
ALTER TABLE EMPLOYEE_SUBQUEY_TEST_1
SET UNUSED (SALARY);

--SALARY IS UNUSED NOW 
SELECT * FROM user_unused_col_tabs;

--DROP SALARY COLUMNS  FROM USER_UNUSED_COL_TABS
ALTER TABLE EMPLOYEE_SUBQUEY_TEST_1 
DROP UNUSED COLUMNS;

--READ ONLY 
ALTER TABLE EMPLOYEE_SUBQUEY_TEST_1 READ ONLY; -- THIS STATEMENTS DON'T ALLOW US FOR DML STATEMENTS

--WRITE ONLY
ALTER TABLE EMPLOYEE_SUBQUEY_TEST_1 READ WRITE; -- THIS STATEMENTS ALLOW US FOR DML STATEMENTS

--DROP TABLE
DROP TABLE EMPLOYEE_SUBQUEY_TEST_1; --WHEN WE DELETE THE TABLE , THE TABLE WILL NOT BE COMPLETELY DELETED , IT FALLS INTO THE RECYCLE BIN LIKE WINDOWS OS

SELECT * FROM user_recyclebin;

--IF WE WANT TO DELETE PERMENANTLY AND THEN WE USE PURGE
DROP TABLE EMPLOYEE_SUBQUEY_TEST_2 PURGE;


--RENAME COLUMN , RENAME TABLE

--RENAME COLUMN
ALTER TABLE EMPLOYEE_SUBQUEY_TEST_2
RENAME COLUMN EMAIL TO MAIL;

--RENAME TABLE
RENAME EMPLOYEE_SUBQUEY_TEST_2 TO EMPLOYEE_SUBQUERY_TEST_2;