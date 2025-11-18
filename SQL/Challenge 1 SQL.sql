--1

SELECT first_name,last_name, customer_id,country FROM customer
WHERE country != 'USA'

--2

SELECT first_name from customer where country='Brazil'

--3


--4
SELECT billing_country from invoice GROUP BY billing_country;

--5
SELECT invoice_date FROM invoice
WHERE CAST(invoice_date as text) LIKE '2009';

SELECT sum(total) from invoice

SELECT sum(total),invoice_date from invoice GROUP BY invoice_date


--6

SELECT invoice_id from invoice
WHERE CAST(invoice_id AS TEXT) LIKE '%37%';

--7

SELECT sum(invoice_id),billing_country from invoice
GROUP BY billing_country;
--8
SELECT sum(total),billing_country from invoice
GROUP BY     billing_country

--9






