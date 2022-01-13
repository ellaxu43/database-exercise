
-- 1. SELECT statement
SELECT * FROM actor;
SELECT last_name FROM actor;
SELECT film_id, title, release_year FROM film;

-- 2. DISTINCT operator 
SELECT DISTINCT(last_name) FROM actor;
SELECT DISTINCT(postal_code) FROM address;
SELECT DISTINCT(rating) FROM film;

-- 3. 