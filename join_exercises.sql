# JOIN lesson 
USE join_example_db;

SHOW TABLES;
DESCRIBE roles;
SELECT * FROM roles;
DESCRIBE users;

SELECT * FROM users;

-- users: 
-- primary key: id 
-- relationship with roles: role_id 
-- fields: id, name, email, role_id

-- roles: 
-- primary key: id
-- relationship with users: id
-- fields : id, name 

-- roles.name <> users.name

-- let's relate the tables 
-- let's from a relationship <3

-- LEFT JOIN
-- grab everything
SELECT *
-- from user as left table
FROM users
-- join it to roles
LEFT JOIN roles 
-- how we want to build that connection
ON users.role_id = roles.id;


-- lets make a linkred join associative
USE world;
SELECT * FROM city;
-- primary key: id 
-- possible association: country code 

SELECT * FROM country LIMIT 2;
DESCRIBE country;

-- primary key: code
-- association: code -> city.CountryCode

SELECT * FROM countrylanguage LIMIT 2;
DESCRIBE countrylanguage;

-- association: CountryCode

SELECT * 
FROM city 
JOIN country 
ON city.CountryCode = country.Code
JOIN countrylanguage
ON country.Code = countrylanguage.CountryCode;

SELECT * 
FROM city
JOIN countrylanguage 
ON city.CountryCode = countrylanguage.CountryCode;

SELECT * 
FROM city 
JOIN countrylanguage
USING(CountryCode);



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
#2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.


SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_manager AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
ORDER BY dept_name ASC;


#3. Find the name of all departments currently managed by women.
#employees
#manager
#department

SELECT gender, CONCAT(e.first_name, ' ', e.last_name) AS full_name,d.dept_name
FROM employees AS e
JOIN dept_manager AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' 
HAVING gender = 'F'
ORDER BY dept_name ASC;

SELECT * FROM dept_manager;
SELECT * FROM employees limit 5;
SELECT * FROM dept_emp LIMIT 5;
SELECT * FROM departments;
SELECT * FROM titles LIMIT 5;

#4. Find the current titles of employees currently working in the Customer Service department.
# dept_emp -> emp_no, dept_no, to_date
#titles -> emp_no, title, to_date
# department-> dept_np, 

# dept_no in dept_emp and emp_no to locate department no 
# use emp_no to find the title. 


SELECT COUNT(de.emp_no),t.title FROM titles AS t 
JOIN dept_emp AS de
ON de.emp_no = t.emp_no
JOIN departments AS departments
ON departments.dept_no = de.dept_no
WHERE departments.dept_name ="Customer Service" AND t.to_date = '9999-01-01'
GROUP BY title
ORDER BY title ASC;



#5. Find the current salary of all current managers.


SELECT 
de.dept_name AS Department_Name, 
CONCAT(em.first_name, ' ', em.last_name)  AS Name, 
s.salary AS Salary 
FROM dept_manager AS dept_m
JOIN salaries AS s
ON dept_m.emp_no = s.emp_no
JOIN departments AS de
ON de.dept_no = dept_m.dept_no
JOIN employees AS em
ON em.emp_no = s.emp_no
WHERE dept_m.to_date = '9999-01-01'
AND s.to_date = '9999-01-01'
ORDER BY de.dept_name ASC;


#6.Find the number of current employees in each department.


SELECT d.dept_no, d.dept_name, COUNT(de.emp_no) FROM dept_emp AS de
JOIN departments
AS d
ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY de.dept_no
ORDER by dept_no;

# 7.Which department has the highest average salary? Hint: Use current not historic information.

SELECT AVG(salary) AS average_salary, dept.dept_name
FROM salaries AS s
JOIN dept_emp as de
ON s.emp_no = de.emp_no
JOIN departments as dept
ON dept.dept_no = de.dept_no
WHERE s.to_date = '9999-01-01'
GROUP BY dept.dept_no
ORDER BY average_salary DESC
LIMIT 1;

#8.Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name, s.salary FROM employees
AS em
JOIN salaries as s
ON em.emp_no = s.emp_no
JOIN dept_emp as dept
ON dept.emp_no = s.emp_no
JOIN departments as depart
ON depart.dept_no = dept.dept_no
WHERE depart.dept_name = 'Marketing' 
AND s.to_date = '9999-01-01'
ORDER BY salary DESC
LIMIT 1;

#9.Which current department manager has the highest salary?

SELECT first_name, last_name,s.salary, dp.dept_name 
FROM employees 
AS em
JOIN dept_manager as dm
ON dm.emp_no = em.emp_no
JOIN departments as dp 
ON dp.dept_no = dm.dept_no
JOIN salaries as s
ON s.emp_no = dm.emp_no
WHERE s.to_date >= CURDATE()
ORDER BY s.salary DESC
LIMIT 1;



SELECT * FROM dept_manager;
SELECT * FROM employees limit 5;
SELECT * FROM dept_emp LIMIT 5;
SELECT * FROM departments;
SELECT * FROM titles LIMIT 5;
SELECT * FROM salaries;
SELECT * FROM dept_manager limit 5;
#10. Determine the average salary for each department. Use all salary information and round your results.

SELECT dept.dept_name, CEILING(AVG(salary)) AS average_salary
FROM salaries AS s
JOIN dept_emp as de
ON s.emp_no = de.emp_no
JOIN departments as dept
ON dept.dept_no = de.dept_no
WHERE s.to_date = '9999-01-01'
GROUP BY dept.dept_no
ORDER BY average_salary DESC;

# 11. Bonus Find the names of all current employees, their department name, and their current manager's name.

SELECT CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name, dp.dept_name, CONCAT(mgr.first_name, ' ', mgr.last_name) AS Manager_name
FROM employees AS e
JOIN dept_emp as de
ON e.emp_no = de.emp_no
JOIN departments as dp
ON dp.dept_no = de.dept_no
JOIN dept_manager AS dm
ON dm.dept_no = de.dept_no
JOIN employees as mgr
ON e.emp_no = mgr.emp_no

WHERE de.to_date ='9999-01-01'
AND dm.to_date = '9999-01-01';


# 12. Bonus Who is the highest paid employee within each department.
SELECT CONCAT(first_name, ' ', last_name) AS Employee_Name, dept_name, salaries.salary

FROM dept_emp

JOIN salaries USING(emp_no)
JOIN departments USING(dept_no)
JOIN employees USING(emp_no)

JOIN (
		SELECT 
		dept_emp.dept_no,
		Max(salaries.salary) AS salary
		FROM salaries 
		JOIN dept_emp USING(emp_no)
		WHERE salaries.to_date > curdate()
		GROUP BY dept_emp.dept_no

) AS highest_salaries 
USING(salary, dept_no);






