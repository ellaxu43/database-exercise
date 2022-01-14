##CASE lesson
USE numbers;

SELECT * FROM numbers;
SELECT 
   n, 
     n % 2, 
     	n % 2 = 0,
   IF(n, 'small', 'large') AS number_description
 FROM numbers;


SELECT 
	n as number,
	CASE 
		WHEN n < 4 THEN 'small'
		WHEN n < 8 THEN 'medium'
		ELSE 'large'
	END AS number_descrption
FROM numbers;

SELECT n, 
	CASE n
		WHEN 4 THEN 'four'
		WHEN 5 THEN 'five'
		ELSE CONCAT('the number is ', n)
	END AS number_description 	
FROM numbers;



SELECT * FROM fruits;

SELECT 
 	name, 
 	IF(
 	quantity > 0,
 	CONCAT('we have ', quantity, ' ', name, 's'),
 	'OUT OF STOCK'
 	)
 	 as message;
 	 
 	 
 SELECT 
     d.dept_name,
     	SUM(IF(e.gender = 'F', 1, 0)) AS 'F',
     	SUM(IF(e.gender = 'M', 1,1)) AS 'M'
FROM employees e 
JOIN dept_manager dm USING (emp_no)
JOIN departments d USING (dept_no)
GROUP by d.dept_name;


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

SELECT emp_no,dept_no, from_date,to_date,
       IF(to_date = '9999-01-01', True, False) AS is_current_employee
FROM dept_emp;


SELECT emp_no,dept_no, from_date,to_date,
       CASE to_date
           WHEN '9999-01-01' THEN 1
           ELSE 0
           END AS is_current_employee
FROM dept_emp
;

#Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name


SELECT first_name, last_name, 
		CASE 
		WHEN LEFT(last_name ,1) BETWEEN 'A' AND 'H' THEN 'A-H'
		WHEN LEFT(last_name ,1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
		WHEN LEFT(last_name ,1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
		END AS alpha_group
FROM employees;



#How many employees (current or previous) were born in each decade?

#182886 in 1950s 
#117138 in 1960s 

SELECT COUNT(*),
		
       CASE 
       
       WHEN birth_date LIKE '195%' THEN '1950s'
       	WHEN  birth_date LIKE '196%' THEN '1960s'
		END AS decade
		
FROM employees
GROUP BY decade;


SELECT 
		
       CASE 
       
       WHEN birth_date LIKE '195%' THEN '1950s'
       	WHEN  birth_date LIKE '196%' THEN '1960s'
		END AS decade
		
FROM employees
GROUP BY decade;

#What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT
    CASE
        WHEN d.dept_name IN ('Research', 'Development') THEN 'R&D'
        WHEN d.dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN d.dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN d.dept_name IN ('Finance', 'Human Resources') THEN 'Finanace & HR'
        ELSE d.dept_name
    END AS dept_group,
    AVG(s.salary) AS avg_salary
FROM departments d
JOIN dept_emp de USING (dept_no)
JOIN salaries s USING (emp_no)
WHERE s.to_date > NOW() AND de.to_date > NOW()
GROUP BY dept_group;