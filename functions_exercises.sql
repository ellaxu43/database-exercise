#Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.


USE employees;
SELECT CONCAT(first_name, " " , last_name) AS full_name 
FROM employees
WHERE last_name LIKE 'E%E';

#Convert the names produced in your last query to all uppercase.
USE employees;
SELECT UPPER(CONCAT(first_name, " " , last_name)) AS full_name 
FROM employees
WHERE last_name LIKE 'E%E';

#Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

SELECT first_name, last_name, hire_date, birth_date, DATEDIFF(CURDATE(),hire_date) AS working_days FROM employees
WHERE birth_date LIKE '%12-25%' 
AND hire_date BETWEEN '1990-01-01' AND '1999-12-31';

#Find the smallest and largest current salary from the salaries table. 
#Min 38623
# Max 40_000

SELECT * FROM salaries;
SELECT emp_no, MIN(salary) FROM salaries
GROUP by emp_no
ORDER by MIN(salary);


SELECT * FROM salaries;
SELECT emp_no, MAX(salary) FROM salaries
GROUP by emp_no
ORDER by MAX(salary);

#Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

SELECT * FROM employees;

SELECT first_name, last_name, birth_date,
LOWER(CONCAT(SUBSTR(first_name,1,1),
SUBSTR(last_name,1,4), 
'_', 
SUBSTR(birth_date,6,2),
SUBSTR(birth_date,3,2)))
AS username
FROM employees
LIMIT 10;