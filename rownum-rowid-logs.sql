--LET'S SAY WE WANT TO ADD A NEW COLUMN TO ALL TABLES IN ONE SESSION
--I WANT TO ADD ACTIVE COLUMN TO ALL TABLES
SELECT
    table_name
FROM
    user_tables;

SELECT
    'ALTER TABLE '
    || table_name
    || ' ADD ACTIVE NUMBER(1) DEFAULT 1; '
FROM
    user_tables;


--NOW LET'S A CREATE A NEW SQL FILE AND EXECUTE ALL THIS STATEMENT 

--and active column added.. to all our connection's tables

--and also we can create other statements for all tables  like this way



--rownum

SELECT
    ROWNUM,
    employee_id,
    first_name,
    last_name,
    salary
FROM
    employees;

SELECT
    ROWNUM,
    employee_id,
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    ROWNUM <= 5;


--rowid

SELECT
    ROWID,
    employee_id,
    first_name,
    last_name,
    salary
FROM
    employees;

--rowid return records'address 

SELECT
    *
FROM
    employees
WHERE
    ROWID = 'AAAEAbAAEAAAADNAAA';


--logs

SELECT
    employee_id,
    first_name
    || ' '
    || last_name name
FROM
    employees;

CREATE TABLE emp_name (
    employee_id   NUMBER PRIMARY KEY,
    name          VARCHAR(15)
);

INSERT INTO emp_name
    SELECT
        employee_id,
        first_name
        || ' '
        || last_name name
    FROM
        employees;

--and above statement give me error because some employees name and surname are more than 15 characters 


--solution

EXEC dbms_errlog.create_error_log('emp_name'); --emp_name is table

DESC err$_emp_name;

--now let's insert again

INSERT INTO emp_name
    SELECT
        employee_id,
        first_name
        || ' '
        || last_name name
    FROM
        employees
    LOG ERRORS REJECT LIMIT UNLIMITED;

--and above statement means when error occurs and insert thosee error to err$_emp_name
 
 --now let's look error logs

SELECT
    *
FROM
    err$_emp_name; 
--and we have 11 errors and this records first_name and last_name concatenations are more than 15 characters
--and also we can see this employee's id and name