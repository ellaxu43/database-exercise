
#1. Find all the current employees with the same hire date as employee 101010 using a sub-query.


SELECT hire_date
	FROM employees
	WHERE emp_no = 101010;
	
SELECT emp_no
	FROM dept_emp
	WHERE to_date> curdate();

	
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
WHERE emp_no IN (
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


SELECT salary, 
    (salary - (SELECT AVG(salary) FROM salaries)) 
    / 
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;
WHERE zscore BETWEEN -1 AND 1;

#Bonus 1. Find all the department names that currently have female managers.


		
SELECT dept_name 
FROM departments
WHERE dept_no IN (
	SELECT dept_no
	FROM dept_manager
	WHERE to_date > curdate()
	IN (SELECT emp_no
		FROM employees 
		WHERE gender = 'F'));

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


