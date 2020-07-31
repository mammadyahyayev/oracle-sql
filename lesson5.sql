--TO_CHAR , TO_DATE , TO_NUMBER ,NVL , NVL2 , NULLIF, CASE , DECODE


--TO_CHAR
SELECT
    sysdate
FROM
    dual;

SELECT
    to_char(sysdate, 'dd.MM.yyyy')
FROM
    dual;

SELECT
    to_char(sysdate, 'dd.MM.yyyy hh:mm:mi:ss AM')
FROM
    dual;

SELECT
    to_char(sysdate, 'dd.MM.yyyy hh24:mm:mi:ss')
FROM
    dual;

SELECT
    employee_id,
    first_name,
    last_name,
    to_char(hire_date, 'dd-MM-yyyy') "DATE"
FROM
    employees;

SELECT
    employee_id,
    first_name,
    last_name,
    to_char(hire_date, 'dd-MM-yyyy hh24:mm:mi:ss') "DATE"
FROM
    employees;

SELECT
    employee_id,
    first_name,
    last_name,
    hire_date,
    to_char(hire_date, 'DD Month YYYY') "DATE",
    to_char(hire_date, 'FMDD Month YYYY') "DATE2"
FROM
    employees;

SELECT
    employee_id,
    first_name,
    last_name,
    hire_date,
    to_char(hire_date, 'FMDDSP Month YYYY') "DATE"
FROM
    employees;
--SP CONVERT NUMBER TO CHARACTER(LETTER EX 17-SEVENTEEN)

SELECT
    employee_id,
    first_name,
    last_name,
    hire_date,
    to_char(hire_date, 'fmddth "OF" Month YYYY') "DATE"
FROM
    employees;

SELECT
    employee_id,
    first_name,
    last_name,
    hire_date,
    to_char(hire_date, 'fmddSPth "OF" Month YYYY') "DATE"
FROM
    employees;

SELECT
    *
FROM
    employees
WHERE
    to_char(hire_date, 'yyyy') = '2003';

SELECT
    *
FROM
    employees
WHERE
    to_char(hire_date, 'MM') = '02';

SELECT
    *
FROM
    employees
WHERE
    to_char(hire_date, 'dd') = '01';

SELECT
    to_char(1345, '9999999')
FROM
    dual;

SELECT
    to_char(1345, '99,99')
FROM
    dual;

SELECT
    to_char(1345, '9999$')
FROM
    dual;

SELECT
    to_char(1345, '9999')
FROM
    dual;

--TO_DATE

SELECT
    TO_DATE('10:12:1995', 'dd:MM:YYYY')
FROM
    dual;

SELECT
    *
FROM
    employees
WHERE
    hire_date > TO_DATE('5-02-2008', 'dd-mm-YYYY');

SELECT
    *
FROM
    employees
WHERE
    hire_date > TO_DATE('5-02-      2008', 'dd-mm-YYYY'); -- ORACLE REMOVE SPACES

SELECT
    TO_DATE('9-3-96', 'DD-MM-RR') "DATE"
FROM
    dual;


--NVL 

SELECT
    employee_id,
    first_name,
    last_name,
    nvl(commission_pct, 0)
FROM
    employees;

--IF COMMISSION_PCT IS NULL , WRITE 0 

SELECT
    employee_id,
    first_name,
    last_name,
    nvl(to_char(manager_id), 'NO MANAGER')
FROM
    employees;


--NVL2 

SELECT
    employee_id,
    first_name,
    nvl2(commission_pct, commission_pct, 0)
FROM
    employees;

--IF COMMISSION_PCT IS NOT NULL AND THEN RETURN COMMISSION_PCT , IF COMMISSION_PCT IS NULL AND THEN RETURN 0

SELECT
    employee_id,
    first_name,
    last_name,
    nvl2(commission_pct, 'SALARY AND COMMISION', 'ONLY SALARY')
FROM
    employees;


--NULLIF

SELECT
    first_name,
    length(first_name),
    last_name,
    length(last_name),
    nullif(length(first_name), length(last_name))
FROM
    employees;

--NULLIF: 
-- IF LENGTH OF FIRST_NAME AND LENGTH OF LAST_NAME IS EQUAL AND THEN RETURN NULL 
--ELSE LENGTH OF FIRST_NAME AND LENGTH OF LAST_NAME IS NOT EQUAL AND THEN RETURN FIRST(THAT MEANS: LENGTH OF FIRST_NAME)
--BECAUSE THAT STAY AT THE POSITION 1



--CASE WHEN

SELECT
    employee_id,
    first_name,
    last_name,
    job_id,
    salary,
    CASE job_id
        WHEN 'AD_PRES'   THEN
            1.5 * salary
        WHEN 'AD_VP'     THEN
            4 * salary
        ELSE
            salary
    END "REVISED SALARY"
FROM
    employees;

SELECT
    employee_id,
    first_name,
    last_name,
    job_id,
    salary,
    CASE
        WHEN job_id = 'AD_PRES' THEN
            1.5 * salary
        WHEN job_id = 'AD_VP'   THEN
            4 * salary
        ELSE
            salary
    END "REVISED SALARY"
FROM
    employees;

SELECT
    employee_id,
    first_name
    || ' '
    || last_name "FULL_NAME",
    CASE
        WHEN employee_id BETWEEN 100 AND 120 THEN
            'GO'
        WHEN employee_id BETWEEN 150 AND 200 THEN
            'NOT GO'
        ELSE
            '---'
    END party_go_or_not_go
FROM
    employees;

SELECT
    employee_id,
    first_name,
    last_name,
    hire_date,
    CASE
        WHEN hire_date = TO_DATE('13-1-2001', 'dd-MM-YYYY') THEN
            'CELEBRATE'
        ELSE
            'NOT CELEBRATE'
    END birthday
FROM
    employees;

SELECT
    employee_id,
    first_name,
    last_name,
    hire_date,
    CASE
        WHEN hire_date > TO_DATE('13-1-2004', 'dd-MM-YYYY') THEN
            'PAST'
        ELSE
            'NOT PAST'
    END anniversary
FROM
    employees;
    
    
    
--DECODE

SELECT
    employee_id,
    first_name,
    last_name,
    job_id,
    salary,
    decode(job_id, 'IT_PROG', salary * 2, 'AD_PRES', salary * 4,
           'AD_VP', salary * 10, salary) revised_salary
FROM
    employees;