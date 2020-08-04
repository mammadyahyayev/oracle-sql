--GROUP FUNCTIONS SUM , MAX , MIN , AVG , COUNT , GROUP BY , HAVING

--SUM
SELECT
    SUM(salary)
FROM
    employees;

--AVG

SELECT
    round(AVG(salary), 2)
FROM
    employees;

--MAX

SELECT
    MAX(salary)
FROM
    employees;

SELECT
    MAX(first_name)
FROM
    employees;

--MIN

SELECT
    MIN(salary)
FROM
    employees;

SELECT
    MIN(first_name)
FROM
    employees;


--COUNT

SELECT
    COUNT(*)
FROM
    employees; -- 107

SELECT
    COUNT(1)
FROM
    employees; -- 107

SELECT
    COUNT(2)
FROM
    employees; -- 107

-- SAME RESULT

--COUNT WITH GROUP BY

SELECT
    job_id,
    COUNT(1)
FROM
    employees
GROUP BY
    job_id; 


--GROUP BY

SELECT
    job_id,
    COUNT(1)
FROM
    employees
GROUP BY
    job_id;

SELECT
    job_id,
    MAX(salary)
FROM
    employees
GROUP BY
    job_id;

SELECT
    department_id,
    job_id,
    SUM(salary)
FROM
    employees
GROUP BY
    department_id,
    job_id;


--HAVING
--HAVING USE WITH GROUP BY INSTEAD OF WHERE CLAUSE

SELECT
    job_id,
    SUM(salary)
FROM
    employees
WHERE
    salary > 20000
GROUP BY
    job_id;  --THIS WORKS 

SELECT
    job_id,
    SUM(salary)
FROM
    employees
WHERE
    SUM(salary) > 20000
GROUP BY
    job_id;  --THIS NOT WORKS 
--BEACUSE WE CANNOT USE GROUP FUNCTIONS IN THE WHERE CLAUSE 
-- WE USE HAVING IN THIS MOMENT

SELECT
    job_id,
    SUM(salary)
FROM
    employees
GROUP BY
    job_id
HAVING
    SUM(salary) > 20000;
    
 --AND ALSO HAVING FUNCTION COMES AFTER GROUP BY FUNCTION   