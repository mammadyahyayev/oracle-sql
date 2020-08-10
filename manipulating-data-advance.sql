--COPY ROWS FROM ANOTHER TABLE
CREATE TABLE copy_row (
    id        NUMBER PRIMARY KEY,
    name      VARCHAR2(40),
    surname   VARCHAR2(40)
);

INSERT INTO copy_row (
    id,
    name,
    surname
)
    SELECT
        employee_id,
        first_name,
        last_name
    FROM
        employees;

--ROWS INSERTED...

SELECT
    *
FROM
    copy_row;

INSERT INTO copy_row (
    id,
    name,
    surname
)
    SELECT
        employee_id,
        first_name,
        last_name
    FROM
        employees
    WHERE
        department_id = 70
    UNION ALL
    SELECT
        employee_id,
        first_name,
        last_name
    FROM
        employees
    WHERE
        department_id = 80;

SELECT
    *
FROM
    copy_row;



--INSERT ALL (UNCONDITIONAL INSERT)

CREATE TABLE emp_teacher (
    id        NUMBER PRIMARY KEY,
    name      VARCHAR2(30),
    surname   VARCHAR2(30),
    salary    NUMBER(5)
);

CREATE TABLE emp_director (
    id        NUMBER PRIMARY KEY,
    name      VARCHAR2(30),
    surname   VARCHAR2(30),
    salary    NUMBER(5)
);

--TABLES CREATED AND NOW LET'S ADD SOME DATA TO THEESE TABLES AT THE SAME TIME

INSERT ALL INTO emp_director (
    id,
    name,
    surname,
    salary
) VALUES (
    employee_id,
    first_name,
    last_name,
    salary
) INTO emp_teacher (
    id,
    name,
    surname,
    salary
) VALUES (
    employee_id,
    first_name,
    last_name,
    salary
) SELECT
      employee_id,
      first_name,
      last_name,
      salary
  FROM
      employees
  WHERE
      employee_id BETWEEN 100 AND 130;

SELECT
    *
FROM
    emp_director;

SELECT
    *
FROM
    emp_teacher;


--ROWS INSERTED...



--INSERT ALL (CONDITIONAL INSERT)
--NOW LET'S FIRST DELETE DATA FROM 2 TABLES

DELETE FROM emp_director;

DELETE FROM emp_teacher;

--NOW LET'S INSERT DATA WITH CONDITIONAL

INSERT
    ALL WHEN salary > 15000 THEN
        INTO emp_director (
            id,
            name,
            surname,
            salary
        )
        VALUES (
            employee_id,
            first_name,
            last_name,
            salary
        )
        WHEN salary > 20000 THEN
            INTO emp_teacher (
                id,
                name,
                surname,
                salary
            )
            VALUES (
                employee_id,
                first_name,
                last_name,
                salary
            )
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    employee_id <> 201;


--ROWS INSERTED...

SELECT
    id
FROM
    emp_teacher
INTERSECT
SELECT
    id
FROM
    emp_director;

--THIS ABOVE STATEMENT SHOW US SAME DATA IN 2 TABLES


--INSERT FIRST

INSERT
    FIRST WHEN salary > 20000 THEN
        INTO emp_director (
            id,
            name,
            surname,
            salary
        )
        VALUES (
            employee_id,
            first_name,
            last_name,
            salary
        )
        WHEN salary > 15000 THEN
            INTO emp_teacher (
                id,
                name,
                surname,
                salary
            )
            VALUES (
                employee_id,
                first_name,
                last_name,
                salary
            )
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    employee_id <> 201;

--When using FIRST, the first condition that is met will be executed and the rest will be ignored. 



--INSERT ALL DIFFERENT COLUMNS

CREATE TABLE teacher_x_test (
    id          NUMBER PRIMARY KEY,
    name        VARCHAR2(40),
    surname     VARCHAR2(40),
    hire_date   DATE
);

CREATE TABLE director_x_test (
    id        NUMBER PRIMARY KEY,
    name      VARCHAR2(40),
    surname   VARCHAR2(40),
    email     VARCHAR2(40)
);

INSERT ALL INTO teacher_x_test VALUES (
    employee_id,
    first_name,
    last_name,
    hire_date
) INTO director_x_test VALUES (
    employee_id,
    first_name,
    last_name,
    email
) SELECT
      employee_id,
      first_name,
      last_name,
      hire_date,
      email
  FROM
      employees;

--ROWS INSERTED...

SELECT
    *
FROM
    teacher_x_test;

SELECT
    *
FROM
    director_x_test;



--CREATE MATRIX

SELECT
    department_id,
    job_id,
    COUNT(1)
FROM
    employees
WHERE
    job_id IN (
        'MK_MAN',
        'MK_REP',
        'PU_CLERK',
        'PU_MAN'
    )
GROUP BY
    department_id,
    job_id
ORDER BY
    1,
    2;


--LET'S CREATE A MATRIX

SELECT
    *
FROM
    (
        SELECT
            department_id,
            job_id
        FROM
            employees
        WHERE
            job_id IN (
                'MK_MAN',
                'MK_REP',
                'PU_CLERK',
                'PU_MAN'
            )
    ) PIVOT (
        COUNT ( 1 )
        FOR job_id
        IN ( 'MK_MAN',
        'MK_REP',
        'PU_CLERK',
        'PU_MAN' )
    )
ORDER BY
    1;
    
    


--MERGE STATEMENT

CREATE TABLE A
(
    ID  NUMBER PRIMARY KEY,
    NAME VARCHAR2(40)
);
    
    

CREATE TABLE B
(
    ID  NUMBER PRIMARY KEY,
    NAME VARCHAR2(40)
);

INSERT INTO A VALUES ( 1, 'SAMIR');
INSERT INTO A VALUES ( 2, 'CABBAR');
INSERT INTO A VALUES ( 3, 'QASIM');

INSERT INTO B VALUES ( 1, 'ASIF');
INSERT INTO B VALUES ( 2, 'CEMIL');


SELECT * FROM A;

SELECT * FROM B;



--CREATE A MERGE STATEMENT
MERGE INTO B 
USING (SELECT * FROM A) A
ON (B.ID = A.ID)
WHEN MATCHED THEN 
UPDATE
SET B.NAME = A.NAME
WHEN NOT MATCHED THEN 
INSERT VALUES ( A.ID , A.NAME);

SELECT * FROM A;

SELECT * FROM B;



--FLASHBACK

DROP TABLE teacher_x_test;

SELECT * FROM recyclebin;

--THIS STATEMENT DELETE ALL OBJECTS FROM RECYCLEBIN
PURGE RECYCLEBIN;


--LET'S RETRIEVE TABLE FROM RECYCLEBIN

FLASHBACK TABLE TEACHER_x_TEST TO BEFORE DROP;

--FLASHBACK SUCCEEDED...

SELECT * FROM TEACHER_x_TEST;
--TABLE RETRIEVED WITH DATA...



--SYSTEM CHANGE NUMBER (SCN)
SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 102;

--SALARY 17000

--LET'S UPDATE THIS SALARY

UPDATE EMPLOYEES SET SALARY = SALARY + 200 WHERE EMPLOYEE_ID = 102;

--NOW SALARY IS 17200

COMMIT;

--IF WE COMMIT AND WE CANNOT ROLL BACK OLD SALARY 


SELECT SALARY FROM
EMPLOYEES VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE EMPLOYEE_ID = 102;

--THIS ABOVE STATEMENT SHOW US SALARY IS 17000 AND 17200 FOR EMPLOYEE_ID 102


--BUT WE DON'T KNOW WHICH VALUE MAX , WHICH VALUE MIN

SELECT VERSIONS_STARTTIME , VERSIONS_ENDTIME , SALARY FROM
EMPLOYEES
VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE EMPLOYEE_ID = 102;

--17200 SALARY'S VERSION'S END TIME IS NULL THAT MEANS THIS VALUE LATEST VALUE
--BUT 17000 SALARY'S VERSIONS END TIME IS 08-AUG-20 04.16.23.000000000 PM
--THAT MEANS THIS VALUE OLD VALUE
--AND NOW WE KNOW WHICH VALUE IS OLD , WHICH VALUE IS NEW

--LET'S UPDATE SALARY TO 17000

UPDATE EMPLOYEES SET SALARY = 17000 WHERE 
EMPLOYEE_ID= 102;

SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 102;

COMMIT;
--SALARY WAS UPDATED... 