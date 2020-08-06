Load Data
INFILE 'D:\oracle-sql-practice\emp.csv'
APPEND
INTO Table EMPLOYEES_LOAD
FIELDS TERMINATED BY','
(id,
name,
surname,
salary
)