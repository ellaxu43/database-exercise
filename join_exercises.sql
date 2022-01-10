# JOIN Example Database

#1. Use the join_example_db. Select all the records from both the users and roles tables.

#2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

#3 Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

#Employees Database
#Use the employees database.
#Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.


SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_manager AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01';


#Find the name of all departments currently managed by women.
#employees
#manager
#department

SELECT gender, CONCAT(e.first_name, ' ', e.last_name) AS full_name,d.dept_name
FROM employees AS e
JOIN dept_manager AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' ;
HAVING d.gender = 'F';

SELECT * FROM dept_manager;
SELECT * FROM employees limit 5;
SELECT * FROM dept_emp LIMIT 5;
SELECT * FROM departments;

#Find the current titles of employees currently working in the Customer Service department.

SELECT emp_no FROM employees 
AS e
JOIN titles  AS t
on e.emp_no = t.emp_no
WHERE title = ''
SELECT * FROM titles;
