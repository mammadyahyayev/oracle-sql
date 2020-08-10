--this show all users in database
select * from all_users;

--this statement show us all system privileges
select * from system_privilege_map;

---let's create a user SYNTAX : create user [user_name] identified by [password] 
create user test IDENTIFIED BY test123;


--now let's give some privileges to test user
grant create session to test;

grant create table to test;

grant unlimited tablespace to test; 
-- this statement allow to test user for use the memory

--grants succeeded...

--and we grant privileges to user at the same statement like this : 
-- grant create session , create table to test

grant create sequence , create synonym , create view to test;


--theese above statements are system privileges




--Object privileges

grant select on hr.employees to test;

--and we give object privileges to test for select statement on hr.employees table 

grant delete on hr.employees to test;

--and now give a privileges on specific column in a table 
grant update (salary) on hr.employees to test;


--now let's give all object privileges on departments table
grant all on hr.departments to test;


grant select , insert on hr.jobs to test;


--now let's give priviliges to all users
grant select on HR.job_test to public;





--creating role
create role manager;

--role created...


--now let's give some privileges to manager role

grant create table , create sequence , create view to manager; 

--this statement show us role's privileges 
select * from role_sys_privs
where role = 'MANAGER';


--create user
create user manager_test identified by managertest123;

--user created

grant UNLIMITED TABLESPACE  to manager_test;

grant create session to manager_test;

--now give the role to user
grant manager to manager_test;



--now let's create other role
create role query_only;

grant select any table to query_only;

grant query_only to manager_test;

 
--now let's create another role which has insert update delete privileges on employee table
create role iud_emp;

grant insert , update , delete on hr.employees to iud_emp;

grant iud_emp to manager_test;


--this statement show us role's privileges
select * from role_tab_privs
where role  = 'IUD_EMP';






--grant option

grant select on HR.job_test_for_fk
to test with GRANT OPTION;

--and we give select privileges to test user and test user can also give same grant to another user like this
-- grant select on HR.job_test_for_fk
-- to manager_test with GRANT OPTION;

--if we don't use grant option , test user doesn't give this grant to another user

--now let's say i want to revoke this grant from test user and i revoke this grant from user and also this grant will be revoked from manager test

revoke select on HR.job_test_for_fk
from test;

--revoke succeeded..



--drop user

--i want to drop user but  this user created some tables , views ,sequence if i drop the user and also tables ,sequence ,views which this user created

drop user test;
--and this statement gave me error

drop user test cascade;