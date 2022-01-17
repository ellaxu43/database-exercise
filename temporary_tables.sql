# USE 
USE innis_1655;


SELECT Database();
SHOW TABLES; 

CREATE TEMPORARY TABLE temptable1(
col1 INT UNSIGNED NOT NULL);

SHOW tables;

SELECT Database();

SHOW TABLES;

SELECT * FROM temptable1;

INSERT INTO temptable1(col1) VALUES (1), (2), (3), (4);

SELECT * FROM temptable1;

-- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
CREATE TEMPORARY TABLE employees_with_departments(
first_name VARCHAR(20) NOT NULL,last_name VARCHAR(20) NOT NULL, dept_name VARCHAR(20));



DROP table employees_with_department;
# Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns


ALTER TABLE employees_with_departments add full_name VARCHAR(40) NOT NULL;

SELECT * FROM employees_with_departments;

# Update the table so that full name column contains the correct data

UPDATE employees_with_departments  
SET full_name = CONCAT(first_name,' ', last_name);

# Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments 
DROP COLUMN first_name, DROP COLUMN last_name
; 

# What is another way you could have ended up with this same table?



#Create a temporary table based on the payment table from the sakila database.

# Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

USE innis_1655;
DROP table Newamount;

CREATE TEMPORARY TABLE Newamount AS (
	SELECT * FROM sakila.payment LIMIT 15
);

DESCRIBE Newamount;

UPDATE Newamount set amount = amount*100;

ALTER TABLE Newamount
MODIFY COLUMN amount INT;

SELECT * FROM Newamount;

#Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

create temporary table historic_aggregates as (
    select avg(salary) as avg_salary, std(salary) as std_salary
    from employees.salaries 
);

create temporary table current_info as (
    select dept_name, avg(salary) as department_current_average
    from employees.salaries
    join employees.dept_emp using(emp_no)
    join employees.departments using(dept_no)
    where employees.dept_emp.to_date > curdate()
    and employees.salaries.to_date > curdate()
    group by dept_name
);

select * from current_info;

alter table current_info add historic_avg float(10,2);
alter table current_info add historic_std float(10,2);
alter table current_info add zscore float(10,2);

update current_info set historic_avg = (select avg_salary from historic_aggregates);
update current_info set historic_std = (select std_salary from historic_aggregates);

select * from current_info;

update current_info 
set zscore = (department_current_average - historic_avg) / historic_std;

select * from current_info
order by zscore desc;

