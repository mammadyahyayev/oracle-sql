select * from session_privs;

--and test user only 5 privileges and above statement show us

--now let's create a table 
create table test_user_tab(
    id number constraint id_pk primary key,
    name varchar2(30),
    surname varchar2(30),
    salary number(5)
);

insert into test_user_tab
values(1 , 'Samir' , 'Samirov' , 1200);

-- row inserted


alter table test_user_tab 
add (hire_date date default sysdate);

select * from test_user_tab;


--now let's create a sequence

create sequence test_user_tab_seq;

--sequence created


--create index
create index surname_uk on test_user_tab (surname);

--index created


--create view
create or replace view test_user_tab_view
as
select id , name ,surname from 
test_user_tab;

--view created



--change test user password

alter user test identified by test;

--password changed...


--and also this user have some privileges on hr database's tables 
select * from hr.employees;



select * from session_privs;

--and this following statement show us user's privileges
select * from user_sys_privs;

--and this statement show us user's privileges which table 
select * from user_tab_privs_recd;

--and this statement show us user's privileges which table's column
select * from user_col_privs_recd;

grant select on test_user_tab TO hr;

--and now hr user can access to test_user_tab

grant update (salary) on test_user_tab to hr;

--this show us which user can access this user's object
select * from user_col_privs_made;
