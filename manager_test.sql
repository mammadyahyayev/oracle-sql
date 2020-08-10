select * from session_privs;

select * from user_sys_privs;

select * from user_role_privs;
--manager_test user have 3 roles : IUD_EMP , MANAGER , QUERY_ONLY

select * from role_sys_privs;
--and this above statement show us which roles have which privileges

select * from role_tab_privs;

create table student 
(
    id number primary key ,
    name varchar2(20) 
);

grant select on student to public;

--this above statement allow to other users for call to student table

select * from HR.locations;

select * from hr.employees;

select * from HR.address_t;

select * from TEST.test_user_tab;

--and this user has select any privileges  and this means
--this user call other user's tables with select statement


--and also this user has IUD_EMP roles 
--and this roles can insert update delete to hr.employees table

insert into hr.employees(employee_id , first_name, last_name , salary , email , hire_date , job_id)
values(1000 , 'samir' , 'samirov' , 1500 , 'qaqa@gmail.com' , sysdate , 'AD_PRES');

--row inserted

--let's update 
update hr.employees set salary = 30000 where employee_id = 101;


--row updated...



--delete employees
delete from hr.employees where employee_id = 1000;


--row deleted...

