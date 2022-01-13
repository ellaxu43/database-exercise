
#1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
	SELECT emp_no
	FROM dept_emp
	WHERE to_date> curdate();

	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010;

	
	SELECT first_name, last_name, hire_date, emp_no FROM employees 
	-- make a condition
	WHERE emp_no 		
	IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date> curdate())
	AND hire_date = (
	-- make a condition
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010);




#2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT title FROM titles 
WHERE emp_no IN (
		SELECT emp_no 
		FROM employees 
		WHERE first_name = 'Aamod'
		AND to_date IN (
		SELECT to_date FROM dept_emp
		WHERE to_date> curdate())

		)
	GROUP BY title;

# 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
#240124 employees are no longer working for this company. 
SELECT COUNT(*)
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no 
	FROM dept_emp
	WHERE to_date > curdate());

# 4. Find all the current department managers that are female. List their names in a comment in your code.
SELECT first_name, last_name, gender
FROM employees
WHERE emp_no IN (
		SELECT emp_no 
		from dept_manager
		WHERE to_date > curdate())
		HAVING gender = 'F';

#5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.	 
	 
SELECT first_name, last_name FROM employees
WHERE emp_no IN 
				( 
					SELECT emp_no
					FROM salaries
					WHERE salary > (SELECT AVG(salary) FROM salaries)
					);
	  

#6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
SELECT
(SELECT COUNT(salary) AS sal_in_1
FROM salaries
WHERE salary >= (SELECT MAX(salary) - STDDEV(salary) FROM salaries WHERE to_date > NOW()) AND to_date > NOW())
/ 
(SELECT COUNT(salary) AS num_sal
FROM salaries
WHERE to_date > NOW()) * 100 AS percent_of_salary;


SELECT COUNT(salary) AS sal_in_1
FROM salaries
WHERE salary >= (SELECT MAX(salary) - STDDEV(salary) FROM salaries WHERE to_date > NOW()) AND to_date > NOW();






#Bonus 1. Find all the department names that currently have female managers.

SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS full_name 
FROM employees AS e
JOIN dept_manager AS dm
	ON dm.emp_no = e.emp_no
JOIN departments  AS d
	ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01'
	AND e.gender ='F';
		


#Bonus 2. Find the first and last name of the employee with the highest salary.# Tokuyasu Pesch


SELECT  emp_no, first_name, last_name
FROM employees
WHERE emp_no IN 
	(
	SELECT emp_no 
	FROM salaries 
	WHERE salary = (
	SELECT max(salary)
	FROM salaries)
	);
	

#Bonus 3. Find the department name that the employee with the highest salary works in. # sales
SELECT dept_name 
FROM departments
WHERE dept_no IN
	(
	SELECT dept_no 
	FROM dept_emp
	WHERE emp_no = 
	(SELECT emp_no 
	FROM salaries 
	WHERE salary = (
	SELECT max(salary)
	FROM salaries)
	)
	);


 