--manipulating data with subquery : INSERTING , UPDATING , DELETING , CORRELATE UPDATE AND DELETE

--INSERTING
INSERT INTO (
SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 10
)
VALUES ( 300 , 'DEPARTMENT A');


--UPDATING
UPDATE 
(
    SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY
    FROM EMPLOYEES WHERE DEPARTMENT_ID = 20
)
SET SALARY = SALARY * 10;


--DELETING
DELETE
(
    SELECT * FROM DEPARTMENTS
    WHERE DEPARTMENT_ID = 300
);


--CORRELATED UPDATE
create table emp_copy
as select * from employees;

UPDATE EMP_COPY 
SET SALARY = 0;

UPDATE EMP_COPY e_copy
SET SALARY = (select salary from employees e where e.employee_id = e_copy.employee_id);

--now let's add 1 data to emp_copy and this data not exist in employees table 
insert into emp_copy(EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID,SALARY)
values              (12345,'A','A','A',sysdate,'IT_PROG',12332);

--if i execute following statement and this statement also update employee id = 12345 but i don't want to update this row
UPDATE EMP_COPY e_copy
SET SALARY = (select salary from employees e where e.employee_id = e_copy.employee_id);

--if a execute following statements and this update statement doesn't update employee id which is 12345
update emp_copy e_copy
set salary=(select salary from employees e where e.employee_id=e_copy.employee_id)
where exists (select 1 from employees e where e.employee_id=e_copy.employee_id);

select *  from emp_copy;




--correlate delete
delete from emp_copy
where exists (select 1 from employees e where e.employee_id=emp_copy.employee_id);

--this statement delete everything from emp_copy which datas are the same at in employees table

select * from emp_copy;