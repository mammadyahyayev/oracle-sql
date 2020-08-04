--CREATE VIEW : SIMPLE VIEW , COMPLEX VIEW , READ ONLY 

CREATE TABLE DOCTOR (
    ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(30) NOT NULL,
    SURNAME VARCHAR2(30) NOT NULL,
    EMAIL VARCHAR2(40) UNIQUE,
    EXPERIENCE NUMBER(2),
    ADDRESS_ID NUMBER,
    ACTIVE NUMBER(1)
);

--ADD CONSTRAINT FOR FOREIGN KEY
ALTER TABLE DOCTOR
ADD CONSTRAINT ADDRESS_DOCTOR_FK FOREIGN KEY(ADDRESS_ID) REFERENCES ADDRESS_T (ID);

--ADD CONSTRAINT FOR ACTIVE
ALTER TABLE DOCTOR 
ADD CONSTRAINT ACTIVE_DOCTOR_CHECK CHECK (ACTIVE IN (1 , 0));

--MODIFY COLUMN ACTIVE AND SET DEFAULT VALUE 1
ALTER TABLE DOCTOR
MODIFY (ACTIVE NUMBER(1) DEFAULT 1);

--CREATE SEQUENCE FOR INSERT AUTOMATICALLY GENERATE ID FOR DOCTOR TABLE
CREATE SEQUENCE DOCTOR_SEQ;

--INSERT STATEMENT 
INSERT INTO DOCTOR(ID , NAME ,SURNAME , EMAIL , EXPERIENCE , ADDRESS_ID )
VALUES (DOCTOR_SEQ.NEXTVAL , 'SAMIR' , 'SAMIROV','SAMIR@GMAIL.COM' , 2 , 1);


--CREATE VIEW 
CREATE VIEW DOCTOR_VIEW
AS
SELECT ID , NAME ,SURNAME , EMAIL FROM DOCTOR;

SELECT * FROM DOCTOR_VIEW;

--VIEW DICTIONARY
SELECT * FROM USER_VIEWS
WHERE VIEW_NAME = 'DOCTOR_VIEW';

--DESCRIBE VIEW
DESC DOCTOR_VIEW;


--INSERT ORIGINAL TABLE
INSERT INTO DOCTOR(ID , NAME ,SURNAME , EMAIL , EXPERIENCE , ADDRESS_ID )
VALUES (DOCTOR_SEQ.NEXTVAL , 'QASIM' , 'QASIMOV','QASIM@GMAIL.COM' , 5 , 2);

SELECT * FROM DOCTOR;

--AND ALSO DATA INSERTED TO VIEW
SELECT * FROM DOCTOR_VIEW;

--INSERT TO VIEW 
INSERT INTO DOCTOR_VIEW(ID , NAME ,SURNAME , EMAIL)
VALUES(DOCTOR_SEQ.NEXTVAL, 'AMIL','AMILOV' , 'AMIL@GMAIL.COM');

--AND ALSO INSERTED TO ORIGINAL TABLE BUT SOME COLUMNS WAS NULL
SELECT * FROM DOCTOR;


--AND I CREATE A VIEW BUT I WANT TO GIVE OTHER NAME TO VIEW COLUMNS
CREATE VIEW DOCTOR_V1
AS
SELECT ID DOCTOR_ID , NAME  FIRST_NAME , SURNAME LAST_NAME , EMAIL GMAIL FROM DOCTOR;

SELECT * FROM DOCTOR_V1;


--AND I CREATE A VIEW FOR ADDRESS
--1.AZERBAIJAN_DOCTOR , TURKEY_DOCTOR

--CREATE AZERBAIJAN_DOCTOR VIEW
CREATE VIEW AZERBAIJAN_DOCTOR
AS
SELECT DOCTOR.ID , DOCTOR.NAME , DOCTOR.SURNAME , DOCTOR.EMAIL ,DOCTOR.EXPERIENCE , ADDRESS_T.COUNTRY FROM DOCTOR 
INNER JOIN ADDRESS_T ON ADDRESS_T.ID  = DOCTOR.ADDRESS_ID 
WHERE ADDRESS_T.COUNTRY = 'AZERBAIJAN';

--DISPLAY THE RESULT
SELECT * FROM AZERBAIJAN_DOCTOR;

--CREATE TURKEY_DOCTOR VIEW
CREATE VIEW TURKEY_DOCTOR
AS
SELECT D.ID DOCTOR_ID , D.NAME , D.SURNAME , D.EMAIL ,D.EXPERIENCE EXP , A.COUNTRY FROM DOCTOR D
INNER JOIN ADDRESS_T A ON A.ID  = D.ADDRESS_ID 
WHERE A.COUNTRY = 'TURKEY';

--DISPLAY THE RESULT
SELECT * FROM TURKEY_DOCTOR;



--COMPLES VIEWS
CREATE VIEW DOCTOR_ADDRESS
AS
SELECT COUNT(D.ID) DOCTOR_COUNT, A.COUNTRY FROM DOCTOR D
INNER JOIN ADDRESS_T A ON A.ID  = D.ADDRESS_ID 
GROUP BY a.country;

SELECT * FROM DOCTOR_ADDRESS;


CREATE OR REPLACE VIEW DOCTOR_SALARY
AS
SELECT A.COUNTRY , COUNT(D.ID) DOCTOR_COUNT, MAX(SALARY) MAX_SALARY , MIN(SALARY) MIN_SALARY  FROM DOCTOR D
INNER JOIN ADDRESS_T A ON A.ID  = D.ADDRESS_ID 
GROUP BY a.country;


SELECT * FROM DOCTOR_SALARY;


--READ ONLY VIEW
CREATE OR REPLACE VIEW CITY_SALARY
AS
SELECT A.CITY , COUNT(D.ID) DOCTOR_COUNT , MAX(D.SALARY) MAX_SALARY , MIN(D.SALARY) MIN_SALARY 
FROM DOCTOR D INNER JOIN ADDRESS_T A ON A.ID = D.ADDRESS_ID
GROUP BY A.CITY 
WITH READ ONLY;

SELECT * FROM CITY_SALARY;

--AND WE CAN NOT INSERT  OR UPDATE OR DELETE OR ANY DML OPERATION IN THIS VIEW 


