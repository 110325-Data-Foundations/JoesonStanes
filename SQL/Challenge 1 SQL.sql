


- Parking Lot*******
-- *                *
-- *                *
--- *****************

-- SETUP:
-- Create a database server (docker)
-- $ docker run --name postgres -e POSTGRES_PASSWORD=testpass -p 5432:5432 -d postgres
-- Create a new database called chinookdb
-- $ docker exec -i postgres psql -U postgres -d chinookdb < "C:\Users\Path\To\Chinook\Psql\File.sql"
-- Connect to the server (Azure Data Studio / Database extension)
-- Test your connection with a simple query (like a select)
-- Execute the Chinook database (from the Chinook_pg.sql file to create Chinook resources in your server)

-- Comment can be done single line with --
-- Comment can be done multi line with /* */

/*
DQL - Data Query Language
Keywords:

SELECT - retrieve data, select the columns from the resulting set
FROM - the table(s) to retrieve data from
WHERE - a conditional filter of the data
GROUP BY - group the data based on one or more columns
HAVING - a conditional filter of the grouped data
ORDER BY - sort the data
*/

SELECT * FROM actor;
SELECT last_name FROM actor;
SELECT * FROM actor WHERE first_name = 'Morgan';
select * from actor where first_name = 'John';

-- BASIC CHALLENGES
-- List all customers (full name, customer id, and country) who are not in the USA
SELECT first_name,last_name, customer_id,country FROM customer
WHERE country != 'USA'

-- List all customers from Brazil
SELECT first_name from customer where country='Brazil'


-- List all sales agents
SELECT billing_country from invoice GROUP BY billing_country;

-- SELECT * FROM employee WHERE title LIKE '%Agent%;
SELECT invoice_date FROM invoice
WHERE CAST(invoice_date as text) LIKE '2009';


-- Retrieve a list of all countries in billing addresses on invoices
SELECT sum(total) from invoice


-- Retrieve how many invoices there were in 2009, and what was the sales total for that year?

SELECT sum(total),invoice_date from invoice GROUP BY invoice_date


-- (challenge: find the invoice count sales total for every year using one query)

SELECT sum(total),billing_country from invoice
GROUP BY     billing_country



-- how many line items were there for invoice #37
SELECT invoice_id from invoice
WHERE CAST(invoice_id AS TEXT) LIKE '%37%';



-- how many invoices per country? BillingCountry  # of invoices 
SELECT sum(invoice_id),billing_country from invoice
GROUP BY billing_country;
--8

-- Retrieve the total sales per country, ordered by the highest total sales first.

-- JOINS CHALLENGES
-- Every Album by Artist
SELECT album.title as album_name,artist.name as artist_name
FROM  album 
INNER JOIN artist On album.artist_id=artist.artist_id


-- (inner keyword is optional for inner join)

-- All songs of the rock genre

SELECT track.name as track_name ,genre.name as genre_name 
FROM track
INNER JOIN genre ON track.genre_id=genre.genre_id
WHERE genre.name='Rock';
-- Show all invoices of customers from brazil (mailing address not billing)

SELECT customer.first_name ,invoice.invoice_id,customer.country 
FROM customer
INNER JOIN invoice ON customer.customer_id=invoice.customer_id
WHERE customer.country='Brazil';

-- Show all invoices together with the name of the sales agent for each one

SELECT i.invoice_id as id,e.title AS Title
FROM invoice as i
INNER JOIN customer as c ON c.support_rep_id=i.customer_id
INNER JOIN employee as e ON c.support_rep_id=e.employee_id
WHERE e.title LIKE '%Sales%Agent%';
-- Which sales agent made the most sales in 2009?

SELECT 
    c.first_name AS name,
    SUM(i.total) AS total_sales
FROM invoice AS i
JOIN customer AS c ON i.customer_id = c.customer_id
JOIN employee AS e ON c.support_rep_id = e.employee_id
WHERE e.title LIKE '%Sales%Agent%'
AND CAST(i.invoice_date AS TEXT) LIKE '2009%'
GROUP BY c.first_name;

-- How many customers are assigned to each sales agent?
SELECT COUNT(c.customer_id) AS customer_count,
e.first_name AS sales_agent

FROM customer as c
INNER JOIN employee as e ON c.support_rep_id=e.employee_id
WHERE e.title LIKE '%Sales%Agent%'
GROUP BY e.first_name;

-- Which track was purchased the most in 2010?

SELECT t.name as track_name ,
COUNT(i.invoice_id) as purchase_count
FROM invoice_line as il
INNER JOIN track as t ON il.track_id=t.track_id
INNER JOIN invoice as i ON il.invoice_id=i.invoice_id

WHERE CAST(i.invoice_date AS TEXT) LIKE '2010%'
GROUP BY t.name;
-- Show the top three best selling artists.




-- Which customers have the same initials as at least one other customer?


-- Which countries have the most invoices?


-- Which city has the customer with the highest sales total?


-- Who is the highest spending customer?


-- Return the email and full name of of all customers who listen to Rock.


-- Which artist has written the most Rock songs?


-- Which artist has generated the most revenue?




-- ADVANCED CHALLENGES
-- solve these with a mixture of joins, subqueries, CTE, and set operators.
-- solve at least one of them in two different ways, and see if the execution
-- plan for them is the same, or different.

-- 1. which artists did not make any albums at all?


-- 2. which artists did not record any tracks of the Latin genre?


-- 3. which video track has the longest length? (use media type table)



-- 4. boss employee (the one who reports to nobody)


-- 5. how many audio tracks were bought by German customers, and what was
--    the total price paid for them?



-- 6. list the names and countries of the customers supported by an employee
--    who was hired younger than 35.




-- DML exercises

-- 1. insert two new records into the employee table.

-- 2. insert two new records into the tracks table.

-- 3. update customer Aaron Mitchell's name to Robert Walter

-- 4. delete one of the employees you inserted.

-- 5. delete customer 

