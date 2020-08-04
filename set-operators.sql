--SET-OPERATORS:  UNION , UNION ALL , INTERSECT , MINUS

--UNION
SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID = 101;

SELECT * FROM JOB_HISTORY
WHERE EMPLOYEE_ID = 101;

SELECT EMPLOYEE_ID , JOB_ID FROM EMPLOYEES
UNION
SELECT EMPLOYEE_ID , JOB_ID FROM JOB_HISTORY;

--UNION DOESN'T ALLOW DUPLICATE VARIABLES 
-- BUT UNION ALL DOES


--UNION ALL
SELECT EMPLOYEE_ID , JOB_ID FROM EMPLOYEES
UNION ALL
SELECT EMPLOYEE_ID , JOB_ID FROM JOB_HISTORY;



--ALIAS IN SET OPERATOR
SELECT EMPLOYEE_ID EMP_ID , JOB_ID JOB FROM EMPLOYEES
UNION ALL
SELECT EMPLOYEE_ID ID , JOB_ID job_id FROM JOB_HISTORY;

--SET OPERATORS  ALWAYS  CHOOSE FIRST ALIAS THAT MEANS ( EMP_ID AND JOB)





--INTERSECT 
SELECT EMPLOYEE_ID EMP_ID , JOB_ID JOB FROM EMPLOYEES
INTERSECT
SELECT EMPLOYEE_ID ID , JOB_ID job_id FROM JOB_HISTORY;

--The SQL INTERSECT operator is used to return the results of 2 or more SELECT statements. 
--However, it only returns the rows selected by all queries or data sets. 
--If a record exists in one query and not in the other, it will be omitted from the INTERSECT results.



--MINUS
SELECT EMPLOYEE_ID EMP_ID , JOB_ID JOB FROM EMPLOYEES
MINUS
SELECT EMPLOYEE_ID ID , JOB_ID job_id FROM JOB_HISTORY;

--The SQL MINUS operator is used to return all rows in the first SELECT statement that are not returned by the second SELECT statement.
--Each SELECT statement will define a dataset. 
--The MINUS operator will retrieve all records from the first dataset and 
--then remove from the results all records from the second dataset.


