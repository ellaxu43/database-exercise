#2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file. 
#7 

SELECT COUNT(DISTINCT(title)) FROM titles;

#3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT DISTINCT(last_name) FROM employees
WHERE last_name 
LIKE 'E%E'
GROUP BY last_name;

#4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT last_name, first_name
FROM employees
WHERE last_name
LIKE 'E%E'
GROUP BY last_name,first_name;

#5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code. CHELQ, LINDQCIST, QIWEN. 

SELECT DISTINCT(last_name) FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%';

#6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name. 
SELECT last_name, COUNT(last_name) FROM employees
GROUP BY last_name
HAVING COUNT(last_name)>1;

SELECT DISTINCT(last_name),COUNT(*)
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

#7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. 441  in M and 268 in F

SELECT first_name , gender, COUNT(first_name) FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender, first_name;

SELECT first_name, gender,COUNT(*) FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;

#8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there? 

# There are 13251 duplicates. 
# There are 3000024 usernames. 
# There are 286773 unique usernames.

SELECT 300024 - 13251;


SELECT LOWER(
			CONCAT(
					SUBSTR(first_name,1,1),
						SUBSTR(last_name,1,4), 
							'_', 
						SUBSTR(birth_date,6,2),
						SUBSTR(birth_date,3,2)
						)
					)
AS username,
COUNT(*)
AS duplicate_usernames
FROM employees
GROUP BY username
HAVING COUNT(username) >= 2
ORDER BY duplicate_usernames DESC;

SELECT LOWER(
			CONCAT(
					SUBSTR(first_name,1,1),
						SUBSTR(last_name,1,4), 
							'_', 
						SUBSTR(birth_date,6,2),
						SUBSTR(birth_date,3,2)
						)
					)
AS username,
COUNT(*)
AS num_shared
FROM employees
GROUP BY username
ORDER BY num_shared DESC;




#More practice with aggregate functions:

#9.1 Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column. 



SELECT AVG(salary), emp_no FROM salaries
GROUP BY emp_no;


#9.2 Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.

SELECT  dept_no, COUNT(emp_no) 
FROM dept_emp
WHERE to_date = '9999-01-01'
GROUP by dept_no;

SELECT dept_no, COUNT(*)
FROM dept_emp
WHERE to_date > NOW()
GROUP BY dept_no;

#SELECT * FROM dept_emp;
#9.3 Determine how many different salaries each employee has had. This includes both historic and current.


SELECT emp_no, COUNT(salary) FROM salaries
GROUP BY emp_no;

SELECT emp_no, COUNT(*) FROM salaries
GROUP BY emp_no;

#9.4 Find the maximum salary for each employee.
SELECT MAX(salary), emp_no FROM salaries
GROUP BY emp_no;

#9.5 Find the minimum salary for each employee.
SELECT MIN(salary), emp_no FROM salaries
GROUP BY emp_no;

#9.6Find the standard deviation of salaries for each employee.

SELECT STDDEV(salary), emp_no FROM salaries
GROUP BY emp_no;

#9.7 Now find the max salary for each employee where that max salary is greater than $150,000.

SELECT MAX(salary) AS max_sal, emp_no FROM salaries
GROUP By emp_no
HAVING max_sal > 150000;

#9.8 Find the average salary for each employee where that average salary is between $80k and $90k.

SELECT AVG(salary), emp_no FROM salaries
GROUP By emp_no
HAVING AVG(salary) BETWEEN 80000 and 90000;

SELECT emp_no, AVG(salary) as avg_sal
FROM salaries
GRoup by emp_no 
HAVING avg_sal BETWEEN 80000 




