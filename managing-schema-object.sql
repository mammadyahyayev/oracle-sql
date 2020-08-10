--MANAGING SCHEMA OBJECT:ADDING , DROPPING CONSTRAINT , RENAME COLUMN , RENAME CONSTRAINT , ENABLE , DISABLE CONSTRAINT  ,
--DEFFERABLE CONSTRAINT , GLOBAL TEMPORARY TABLE , SQL LOADER , EXTERNAL TABLES


--ADDING CONSTRAINT 

--NOW FIRST CREATE TEST TABLE  

CREATE TABLE DOCTOR_TEST_V1
(
    ID NUMBER,
    NAME VARCHAR2(25),
    SURNAME VARCHAR2(20),
    SALARY NUMBER(6)   
);

--CHECK DOCTOR_TEST_V1 TABLE'S CONSTRAINTS
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DOCTOR_TEST_V1';
--AND NO CONSTRAINT


--NOW WE ADD A PRIMARY KEY CONSTRAINT FOR ID 

ALTER TABLE DOCTOR_TEST_V1
ADD CONSTRAINT DOCTOR_TEST_V1_PK PRIMARY KEY(ID);

--CHECK AGAIN
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DOCTOR_TEST_V1';

--NOW WE HAVE A PRIMARY KEY CONSTRAINT AND ITS NAME IS DOCTOR_TEST_V1_PK


--NOW I WANT TO ADD FOREIGN KEY CONSTRAINT BUT THIS TABLE HAS NO FOREIGN KE COLUMN LET'S FIRST ADD COLUMN 
ALTER TABLE DOCTOR_TEST_V1
ADD ADDRESS_ID NUMBER CONSTRAINT ADDRESS_ID_FK_DOC_TEST REFERENCES ADDRESS_T (ID);

--AND WE CREATE A NEW COLUMN LIKE THIS AND WE CAN ADD CONSTRAINT AT THE SAME TIME 

--CHECK NEW COLUMN AND NEW CONSTRAINT
--ADD SOME DATA
INSERT INTO DOCTOR_TEST_V1(ID , NAME , SURNAME , SALARY , ADDRESS_ID)
VALUES(2,'SAMIR','SAMIROV',1200 , 8);

--LET'S CHECK , CONSTRAINT WORKS OR NOT
SELECT D.ID , D.NAME, D.SURNAME , D.SALARY , A.COUNTRY , A.CITY , A.STREET , A.POSTAL_CODE 
FROM DOCTOR_TEST_V1 D INNER JOIN ADDRESS_T A ON A.ID = D.ADDRESS_ID;  

--IT IS WORKING

--NOW LET'S CREATE ANOTHER FOREIGN KEY BUT THIS TIME FIRST CREATE A COLUMN AND THEN ADD A CONSTRAINT
ALTER TABLE DOCTOR_TEST_V1
ADD EMPLOYEE_ID NUMBER;

--EMPLOYEE_ID WAS ADDED TO TABLE

--NOW ADD CONSTRAINT FOR EMPLOYEE_ID
ALTER TABLE DOCTOR_TEST_V1
ADD CONSTRAINT DOCTOR_TEST_V1_EMP_FK FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID);

--LET'S CHECK IF THE CONSTRAINT WAS ADDED OR NOT
--UPDATE DATA
UPDATE DOCTOR_TEST_V1 SET EMPLOYEE_ID = 105 WHERE ID = 1;

SELECT D.ID , D.NAME, D.SURNAME , D.SALARY , A.COUNTRY , A.CITY , A.STREET , A.POSTAL_CODE  ,E.FIRST_NAME EMP_NAME, E.LAST_NAME EMP_SURNAME, E.SALARY EMP_SALARY
FROM DOCTOR_TEST_V1 D INNER JOIN ADDRESS_T A ON A.ID = D.ADDRESS_ID
INNER JOIN EMPLOYEES E ON E.EMPLOYEE_ID = d.employee_id;  

--IT IS WORKING 

--NOW LET'S ADD NOT NULL CONSTRAINT 
ALTER TABLE DOCTOR_TEST_V1
MODIFY SURNAME NOT NULL;

--CHECK THIS TABLE CONSTRAINTS
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DOCTOR_TEST_V1';

--AND ALSO NOT NULL CONSTRAINT WAS ADDED...


--ADD UNIQUE CONSTRAINT

--METHOD 1
ALTER TABLE DOCTOR_TEST_V1
MODIFY NAME UNIQUE;


--METHOD 2 
ALTER TABLE DOCTOR_TEST_V1
ADD CONSTRAINT DOCTOR_TEST_V1_SALARY_U UNIQUE (SALARY);

--CHECK THE CONSTRAINTS
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DOCTOR_TEST_V1';

--AND BOTH METHODS ARE WORKING

--AND I ADD SECOND CONSTRAINT FOR SALARY FIRST CONSTRAINT UNIQUE , SECOND CONSTRAINT CHECK CONSTRAINT AND 2 CONSTRAIN WAS ADDED...
ALTER TABLE DOCTOR_TEST_V1
ADD CONSTRAINT SALARY_CHECK_DOCT_TEST CHECK(SALARY > 500);

SELECT * FROM doctor_test_v1;

--NOW LET'S CHECK SALARY'S CONSTRAINTS
INSERT INTO DOCTOR_TEST_V1(ID , NAME ,SURNAME , SALARY , ADDRESS_ID , EMPLOYEE_ID)
VALUES(2 , 'SAMIRE' , 'SAMIROV' , 1300 , 4 , 101);

--AND WE ADD THEES CONSTRAINT
--1.ID - PRIMARY KEY
--2.NAME MUST BE UNIQUE
--3. SURNAME CAN NOT BE NULL
--4. SALARY MUST BE UNIQUE AND GREATER THAN 500






--DROP CONSTRAINTS 

--WE DROP THE PRIMARY KEY
ALTER TABLE DOCTOR_TEST_V1
DROP CONSTRAINT DOCTOR_TEST_V1_PK;

--CHECK
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DOCTOR_TEST_V1';

--PRIMARY KEY WAS DROPPED...


--DROP CONSTRAINT SYNTAX
-- ALTER TABLE [TABLE NAME]
-- DROP CONSTRAINT [CONSTRAINT NAME]


--AND LET'S ASSUME I WANT TO DROP  ADDRESS_T TABLE'S PRIMARY KEY CONSTRAINT IF WE DON'T GIVE ANY NAME TO PRIMARY KEY AND WE CAN WRITE DROP PRIMARY KEY
ALTER TABLE ADDRESS_T
DROP PRIMARY KEY;

--AND THIS STATEMENT GIVE ERROR BECAUSE THIS PRIMARY KEY IS REFERENCED FOREIGN KEY 
ALTER TABLE ADDRESS_T
DROP PRIMARY KEY CASCADE;

--THIS STATEMENT DROPS THE PRIMARY KEY

--AND ALSO WE CAN DROP ADDRESS_T PRIMARY KEY AND DOCTOR_TEST_V1 ADDRESS_ID FOREIGN KEY AT THE SAME TIME 

ALTER TABLE ADDRESS_T
DROP COLUMN ID CASCADE CONSTRAINTS;

--THIS STATEMENTS DROP THE ADDRESS_T PRIMARY KEY AND THEIR CONSTRAINTS 





--RENAME COLUMN AND RENAME CONSTRAINT

--RENAME COLUMN
ALTER TABLE  DOCTOR_TEST_V1
RENAME COLUMN SALARY TO DOCTOR_SALARY;

--CHECK 
SELECT * FROM DOCTOR_TEST_V1;

--COLUMN RENAMED


--RENAME CONSTRAINT
ALTER TABLE DOCTOR_TEST_V1
RENAME CONSTRAINT SYS_C008455 TO NAME_UK_FOR_DOC_TEST;

--CHECK
SELECT * FROM user_constraints
WHERE TABLE_NAME = 'DOCTOR_TEST_V1'

--CONSTRAINT RENAMED




--DISABLE AND ENABLE CONSTRAINT

--DISABLE CONSTRAINT 
ALTER TABLE DOCTOR_TEST_V1
DISABLE CONSTRAINT DOCTOR_TEST_V1_EMP_FK;

--CHECK
SELECT CONSTRAINT_NAME , TABLE_NAME , CONSTRAINT_TYPE , STATUS FROM user_constraints
WHERE TABLE_NAME = 'DOCTOR_TEST_V1'

--CONSTRAINT DISABLED



--ENABLE CONSTRAINT
ALTER TABLE DOCTOR_TEST_V1
ENABLE CONSTRAINT DOCTOR_TEST_V1_EMP_FK;

--CHECK
SELECT CONSTRAINT_NAME , TABLE_NAME , CONSTRAINT_TYPE , STATUS FROM user_constraints
WHERE TABLE_NAME = 'DOCTOR_TEST_V1'


--CONSTRAINT ENABLED..

--THIS STATEMENT SHOWS US WHICH CONSTRAINTS CONTAINS OF WHICH COLUMNS 
SELECT * FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'DOCTOR_TEST_V1';




--DEFFERABLE CONSTRAINT
--NOW LET'S CREATE A NEW TABLE

CREATE TABLE WELDER(
    ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(20),
    SURNAME VARCHAR2(20),
    SALARY NUMBER(6),
    CONSTRAINT SALARY_CHECK_FOR_WELDER CHECK (SALARY > 100)
);

--TABLE CREATED AND NOW ADD SOME DATA
INSERT INTO WELDER(ID , NAME , SURNAME ,SALARY)
VALUES(1, 'SAMIR' , 'SAMIROV', 50);

--THIS STATEMENT GIVE ME ERROR BECAUSE I INSERT 50 TO SALARY COLUMN BUT I HAVE A CONSTRAINT SALARY MUST BE GREATER THAN 100 
--ERROR SAYS: check constraint (HR.SALARY_CHECK_FOR_WELDER) violated


--LET'S CREATE SAME TABLE BUT THIS TIME WE CREATE DEFFERABLE CONSTRAINT 
-- AND ALSO WE ADD DEFFERABLE CONSTRAINT WITH 2 METHOD ,  FIRST : WITH ALTER STATEMENT ,SECOND : WHILE CREATING TABLE 

--METHOD 1 (WITH ALTER STATEMENT)
ALTER TABLE WELDER
ADD CONSTRAINT SALARY_CHECK_FOR_WELDER CHECK (SALARY > 100) DEFERRABLE INITIALLY DEFERRED;

--CHECK CONSTRAINT IS DEFERRED OR NOT
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'WELDER';

--NOW LET'S ADD  DATA TO WELDER
INSERT INTO WELDER(ID , NAME , SURNAME ,SALARY)
VALUES(1, 'SAMIR' , 'SAMIROV', 50);

--RESULT : 1 ROW INSERTED 
--BUT THIS STATEMENT MUST GIVE AN ERROR BECAUSE SALARY IS LESS THAN 100 
--OK DEFFERABLE CONSTRAINT ALLOW ADD DATA BUT THIS IS NOT TRUE 
--DEFERRABLE CONSTRAINT GIVES ME ERROR WHEN I TRY TO COMMIT 
--WHEN I COMMIT AND ORACLE ROLL BACK AND THEN COMMIT .




--GLOBAL TEMPORARY TABLE

--A temporary table is a table that holds data only for the duration of a session or transaction.
--the data stored in the global temporary table is private to the session. 
--In other words, each session can only access its own data in the global temporary table.

CREATE GLOBAL TEMPORARY TABLE WELDER_TEMPORARY
( ID NUMBER , NAME VARCHAR2(20) , SURNAME VARCHAR2(20))
ON COMMIT DELETE ROWS;


INSERT INTO WELDER_TEMPORARY(ID , NAME ,SURNAME )
VALUES (3 , 'SAMIR' , 'SAMIROV');


SELECT * FROM WELDER_TEMPORARY;

--NOW WE HAVE 3 ROWS LET'S TRY TO COMMIT
COMMIT;

--CHECK AGAIN
SELECT * FROM WELDER_TEMPORARY;

--WE HAVE NO ROWS BECAUSE WE COMMIT AND WHEN WE TRY TO COMMIT , DATA WILL BE REMOVED

CREATE  GLOBAL TEMPORARY TABLE WELDER_TEMPORARY_PRESERVE
(ID NUMBER , NAME VARCHAR2(20) , SURNAME VARCHAR2(20))
ON COMMIT PRESERVE ROWS;

--TEMPORARY TABLE ALSO CREATED

--LET'S ADD SOME DATA
INSERT INTO WELDER_TEMPORARY_PRESERVE(ID , NAME ,SURNAME )
VALUES (1 , 'SAMIR' , 'SAMIROV');

INSERT INTO WELDER_TEMPORARY_PRESERVE(ID , NAME ,SURNAME )
VALUES (2 , 'SAMIR' , 'SAMIROV');

INSERT INTO WELDER_TEMPORARY_PRESERVE(ID , NAME ,SURNAME )
VALUES (3 , 'SAMIR' , 'SAMIROV');


SELECT * FROM WELDER_TEMPORARY_PRESERVE;

COMMIT;

--WE COMMIT  BUT DATA WASN'T DELETED.. DATA WILL  BE DELETED WHEN SESSION IS ENDED AND OTHER MEANS WHEN WE EXIT THE SQL DEVELOPER , DATA WILL BE DELETED 


--SQL LOADER

--let's say we have a csv file (Excel file) and we want to load data to table from excel file 
--and this moment we use sql loader
--we need a table and control file (employee.ctl)

/*
LOAD DATA
INFILE 'D:\oracle-sql-practice\employees.csv
APPEND
INTO TABLE EMPLOYEES_LOAD
FIELDS TERMINATED BY ','
(ID,
NAME,
SURNAME,
SALARY
)


--then create a table called EMPLOYEES_LOAD
--NOW LET'S CREATE employee.ctl (control file) and add above statement into control file 
*/

--create a table

CREATE TABLE EMPLOYEES_LOAD
(   ID number,
    NAME VARCHAR2(50),
    SURNAME VARCHAR2(60),
    SALARY  number(6)
);

SELECT * FROM EMPLOYEES_LOAD;
--TABLE IS EMPTY

--NOW LET'S CREATE CONTROL FILE , ADD THE ABOVE STATEMENT TO THE CONTROL FILE 
--and then we execute this statement - sqlldr control=D:\oracle-sql-practice\employee.ctl log=D:\oracle-sql-practice\employee.log
--we have to add above statement to the CMD and cmd asks username and password
--username : hr@XE   password : hr


--let's check and data was loaded successfully...
SELECT * FROM EMPLOYEES_LOAD;



--EXTERNAL TABLES (CREATE EXTERNAL TABLES WITH ORACLE_LOADER)
CREATE OR REPLACE DIRECTORY EMP_DIR
AS 'D:\oracle-sql-practice\external';

--we don't execute this statement because we have not permisson 
--now let's give a permisson ti us 

--and open sqlplus and write the following code in order
-- sys as sysdba -- this is username and then sqlplus asks for type password
-- and then write this statement ----- GRANT CREATE ANY DIRECTORY TO HR;
-- Result : Grant Successeded

--now let's execute following statement
CREATE OR REPLACE DIRECTORY EMP_DIR
AS 'D:\oracle-sql-practice\external';

--result: Directory EMP_DIR created.

--THIS IS DIRECTORY DICTIONARY AND 3 COLUMN 1-OWNER  , 2-DIRECTORY NAME , 3 - DIRECTORY PATH (D:\oracle-sql-practice\external)
SELECT * FROM ALL_DIRECTORIES
WHERE DIRECTORY_NAME = 'EMP_DIR';


--NOW LET'S CREATE DIRECTORY IN THE FILE EXPLORER AND ITS PATH IS : D:\oracle-sql-practice\external
--AND THEN WE CREATE EXCEL FILE  CALLED employee.csv and add some data 


--NOW LET'S CREATE TABLE AND INSERT DATA FROM employee.csv file while creating table
CREATE TABLE EMPLOYEE_LOAD_EXT
(   
    ID      NUMBER,
    NAME    VARCHAR2(30),
    SURNAME VARCHAR2(30),
    SALARY  NUMBER(6)
)
ORGANIZATION EXTERNAL
(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY EMP_DIR
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ','
    )
    LOCATION ('employee.csv')
)
    reject limit unlimited;

--table was created..

--and also data  was loaded successfuly...
SELECT  * FROM EMPLOYEE_LOAD_EXT;

--and let's some changes in excel file and when we change excel file also table will changed
SELECT  * FROM EMPLOYEE_LOAD_EXT;

--but we can not change table in sql developer because this is external tables we only change table  from excel file 

--TABLE WAS CHANGED...


--EXTERNAL TABLES (CREATE EXTERNAL TABLES WITH ORACLE_DATAPUMP)
CREATE TABLE EMPLOYEE_EXTERNAL_DMP
(ID ,
NAME ,
SURNAME ,
SALARY ,
HIRE_DATE 
)
ORGANIZATION EXTERNAL 
(
    TYPE ORACLE_DATAPUMP
    DEFAULT DIRECTORY EMP_DIR
    LOCATION ('EMP.dmp')
)
AS
SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY , HIRE_DATE 
FROM EMPLOYEES;

--TABLE CREATED
SELECT * FROM EMPLOYEE_EXTERNAL_DMP;



--NOW LET'S READ DATA FROM EMP.dmp FILE 
CREATE TABLE EMP_EXTERNAL_READ_DMP
(ID NUMBER,
NAME VARCHAR2(30),
SURNAME VARCHAR2(30), 
SALARY NUMBER(6) ,
HIRE_DATE DATE
)
ORGANIZATION EXTERNAL
(TYPE ORACLE_DATAPUMP
DEFAULT DIRECTORY EMP_DIR
LOCATION ('EMO.dmp')
);

--TABLE CREATED  AND LET'S CHECK THE TABLE DATA LOADED OR NOT
SELECT * FROM EMP_EXTERNAL_READ_DMP;



