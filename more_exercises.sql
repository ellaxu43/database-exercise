
-- 1. SELECT statement
SELECT * FROM actor;
SELECT last_name FROM actor;
SELECT film_id, title, release_year FROM film;

-- 2. DISTINCT operator 
SELECT DISTINCT(last_name) FROM actor;
SELECT DISTINCT(postal_code) FROM address;
SELECT DISTINCT(rating) FROM film;

-- 3.a, WHERE clause, Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
SELECT * FROM film;
SELECT title, description, rating, length 
FROM film
WHERE length > 180;

-- 3.b, Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
SELECT payment_id, amount, payment_date 
FROM payment
WHERE payment_date > 05/27/2005;

-- 4.a IN operator Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.

SELECT * FROM address;

SELECT phone, district 
FROM address 
WHERE district 
IN ('California', 'England', 'Taipei')
;

-- 4. b, Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
SELECT * FROM payment;
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date
LIKE '2005-05-25%';

SELECT date(payment_date) FROM payment;

SELECT * FROM payment;
SELECT payment_id, amount, payment_date
FROM payment
WHERE date(payment_date) # modified the payment date and time to just time. 
IN ('2005-05-25', '2005-05-27', '2005-05-29');


-- 4. c Select all columns from the film table for films rated G, PG-13 or NC-17.

SELECT  * FROM film; 

SELECT title, description, rating FROM film
WHERE rating IN ('G', 'PG-13', 'NC-17');

-- 5. a BETWEEN operator Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
SELECT * FROM payment;
DESCRIBE payment;

SELECT payment_id, amount, payment_date 
FROM payment
WHERE payment_date
BETWEEN '2005-05-25 00:00:01' AND '2005-05-25 23:59:59';



-- 5. b BETWEEN operator Select the film_id, title, and descrition columns from the film table for films where the length of the description is between 100 and 120.

SELECT *, LENGTH(description) FROM film
WHERE LENGTH(description)
BETWEEN 100 AND 120;

-- 6. a LIKE OPERATOR 
#Select the following columns from the film table for rows where the description begins with "A Thoughtful"

SELECT * FROM film
WHERE description 
LIKE 'A Thoughtful%';

-- 6. c LIKE OPERATOR 
#Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
SELECT * FROM film
WHERE description
LIKE '%Database%'
AND length > 180;

-- 7. b LIMIT OPERATOR
#Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
SELECT * FROM payment;

SELECT payment_date, amount  FROM payment
WHERE amount > 5 
LIMIT 1000
OFFSET 1000;

-- 8. a. ORDER BY statement skipped. 

-- 9, JOINs
# Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
#Label customer first_name/last_name columns as customer_first_name/customer_last_name
#Label actor first_name/last_name columns in a similar fashion.
#returns correct number of records: 620
SELECT * FROM actor;
SELECT * FROM customer;
SELECT * FROM film_actor;


SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, a.first_name AS actor_first_name, a.last_name AS actor_last_name
FROM customer AS c
LEFT JOIN actor AS a
ON  c.last_name = a.last_name;
-- 9. b
#Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)

SELECT c.first_name AS customer_first_name, 
			c.last_name AS customer_last_name, 
			a.first_name AS actor_first_name, 
			a.last_name AS actor_last_name
FROM customer AS c
RIGHT JOIN actor AS a
ON  c.last_name = a.last_name;

-- 9. c
#Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
#returns correct number of records: 43
SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, a.first_name AS actor_first_name, a.last_name AS actor_last_name
FROM customer AS c
INNER JOIN actor AS a
ON  c.last_name = a.last_name;


-- 9. d
#Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
#Returns correct records: 600

SELECT * FROM country;
SELECT city, country_id 
FROM city as c 
LEFT JOIN country 
USING(country_id);

-- 9. e 
#Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column. 

SELECT * FROM language;

SELECT description, release_year, name
FROM film
LEFT JOIN language 
USING(language_id);

-- 9. f 
#Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.

SELECT * FROM staff;
SELECT * FROM address;
SELECT * FROM city;

SELECT first_name, last_name, a.address, a.address2, a.postal_code 
FROM staff AS s 
LEFT JOIN address as a
USING(address_id)
LEFT JOIN city as c
USING(city_id);

-- More exercises on sakilia 

-- 1. What is the average replacement cost of a film? Does this change depending on the rating of the film?

SELECT rating, AVG(replacement_cost) FROM film
GROUP BY rating;

-- 2. How many different films of each genre are in the database?
SELECT * FROM film;

SELECT name, count(*) FROM category
JOIN film_category
USING(category_id)
GROUP BY name;

-- 3. What are the 5 frequently rented films?

SELECT * FROM rental;
SELECT * FROM payment;

SELECT title, COUNT(*) from film as f
JOIN inventory as i
USING(film_id)
JOIN rental as r
USING(inventory_id)
JOIN payment as p
USING(rental_id)
GROUP BY title
ORDER by COUNT(*) DESC
LIMIT 5;


-- 4 What are the most most profitable films (in terms of gross revenue)?
SELECT * FROM film;

SELECT title, SUM(amount) from film as f
JOIN inventory as i
USING(film_id)
JOIN rental as r
USING(inventory_id)
JOIN payment as p
USING(rental_id)
GROUP BY title
ORDER by SUM(amount) DESC
LIMIT 5;



-- 5. Who is the best customer?

SELECT first_name, last_name, SUM(p.amount) from customer 
JOIN payment AS p
USING(customer_id)
GROUP BY customer_id 
ORDER BY SUM(p.amount) DESC 
LIMIT 1;

-- 6. Who are the most popular actors (that have appeared in the most films)?
SELECT first_name, last_name, COUNT(*) 
FROM actor 
JOIN film_actor 
USING(actor_id)
GROUP BY actor_id
ORDER BY COUNT(*) DESC
LIMIT 5;


-- 8. What are the sales for each store for each month in 2005?
SELECT NOW();
USE innis_1655;
SELECT CONTACT( 1, 2);

SELECT CONCAT('W3Schools', '.com');

SELECT * FROM numbers_with_groups
ORDER BY category DESC, n;
 LIMIT 4;
 
 
 SELECT n,count(*) FROM numbers_with_groups GROUP BY category;
 SELECT SUBSTR("Data Scienterrific", 10, LENGTH("Data Scienterrific"));
 
select firstname,lastname, prod_desc from customers 
join current_products 
using(prod_id);

SELECT * FROM numbers_with_groups;
WHERE n < 3 or category 'c';

SELECT n, count(*) FROM numbers_with_groups
group by n;
select make, count(*) from cars
group by car_id

SELECT make, model, horsepower FROM cars 
WHERE engine_id IN (SELECT id FROM engines); 

select make, model, horsepower from cars 
where engine_id in ( select is from engines);
SELECT * FROM numbers2;

SELECT n