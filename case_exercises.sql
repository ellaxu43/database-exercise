USE employees;

SELECT dept_name,
       CASE dept_name
       WHEN 'research' THEN 'Development'
       WHEN 'marketing' THEN 'Sales'
       ELSE dept_name
       END AS dept_group
FROM departments;

USE employees;

SELECT dept_name,
       CASE 
           WHEN dept_name IN ('research', 'development') THEN 'R&D'
           WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
           WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
           ELSE dept_name
           END AS dept_group
FROM departments;

SELECT dept_name,
       IF(dept_name = 'Research', True, False) AS is_research
FROM employees.departments;

SELECT dept_name, 
       dept_name = 'Research' AS is_research
FROM departments;



#Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT emp_no,dept_no, from_date,
       IF(to_date = '9999-01-01', True, False) AS is_current_employee
FROM dept_emp;


SELECT emp_no,dept_no, from_date,
       CASE to_date
           WHEN '9999-01-01' THEN 1
           ELSE 0
           END AS is_current_employee
FROM dept_emp;

#Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name


SELECT first_name, last_name, 
		CASE 
		WHEN LEFT(last_name ,1) BETWEEN 'A' AND 'H' THEN 'A-H'
		WHEN LEFT(last_name ,1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
		WHEN LEFT(last_name ,1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
		END AS alpha_group
FROM employees;

SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no)
GROUP BY dept_name
ORDER BY dept_name;



#How many employees (current or previous) were born in each decade?
SELECT 
       COUNT(CASE WHEN birth_date BETWEEN '195%' AND '196%' THEN '1950s' else null 
       
       END) AS decade
FROM employees;



SELECT * FROM employees;


#What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
