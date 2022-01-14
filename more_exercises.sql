
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


