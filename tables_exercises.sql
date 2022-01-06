USE employees;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
DESCRIBE dept_emp;
DESCRIBE departments;
DESCRIBE salaries;
DESCRIBE dept_manager;
DESCRIBE titles;
SELECT * FROM salaries;

#Which table(s) do you think contain a numeric type column? salaries, dept_manager,dept_emp,titles
#Which table(s) do you think contain a string type column? department, employees, dept_emp,titles
#Which table(s) do you think contain a date type column? slaries, dept_emp, emplyees, dept_manager, titles

# What is the relationship between the employees and the departments tables? They seems don't have relationship but dept_emp related them together. 


SHOW CREATE TABLE dept_manager;