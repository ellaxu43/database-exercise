#Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

USE employees;


#Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table? 
#709
#Irena Reutenauer
#Vidya Awdeh

SELECT * FROM employees
WHERE first_name in('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC;



#Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
#709
#Irena Acton
#Vidya Zweizig
SELECT * FROM employees
WHERE first_name in('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC, last_name ASC;

#Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
#709
#Irena Acton
#Maya Zyda

SELECT * FROM employees
WHERE first_name in('Irena', 'Vidya', 'Maya')
ORDER BY last_name ASC, first_name ASC;


#Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
#899
#Ramzi Erde
#Tadahio Erde
SELECT * FROM employees
WHERE last_name like'%E' 
AND last_name like 'E%'
ORDER BY emp_no;


#Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
#899
#Teiji Eldridge was hired on 1999 11-27
#Sergi Erde was hired on 1985 02-02
SELECT * FROM employees
WHERE last_name like'%E' 
AND last_name like 'E%'
ORDER BY hire_date DESC;

#Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.
#842
#Jouko Dechter
#Khun Bernini
SELECT COUNT(*) FROM employees 
WHERE birth_date like '%12-25%'
ORDER BY hire_date DESC;
