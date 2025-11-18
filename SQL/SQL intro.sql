-- This is a comment in sql
/*
Sql has multiple statemnt / query families

Query - Declare something about the shape of the data ,or the databse schema .
Query - Returning data.. but also altering the data in a table
DQL - Data query Language - SELECT
DML - Data Manipulation Language - INSERT, UPDATE, DELETE
DDL - Data Definition Language - CREATE, ALTER, DROP,Truncate
TCL - Transaction Control Language - COMMIT, ROLLBACK, SAVEPOINT
DCL - Data Control Language - GRANT, REVOKE
*/

-- We are going to start with DQL - SELECT!

SELECT* FROM actor; --SELECT EVERYTHING FROM THE AFTER TALE

--Building from that we can select specific column from the 

SELECT actor_id FROM actor;

-- Lets start liimiting the number of columns we select

SELECT * FROM album LIMIT 10; -- LIMIT THE NUMBER OF ROWS RETURNED TO 10

--nOTOCE IN OUR ALBUM TABLE WE HAVE ALBUM_ID AND ARTIST_ID
-- identify a record in this table Every table needs a primary key
--primary key must be uniques and not null
-- In the album table artist id  primary key in another table denoting some  relationship
---- the different type of realtions include one to one,many to one ,one to many--

--filtering and sorting on selects if we want more thathn a just by filterung by colums by lemiting return rows we need to use things like the where clause

SELECT * FROM album,artist WHERE album.artist_id=artist.artist_id LIMIT 10;
SELECT film_id FROM film_actor WHERE actor_id>4 LIMIT 20;
--We can comnine clauses next lets look at order by

SELECT  name,milliseconds FROM track 

ORDER BY milliseconds DESC LIMIT 10;


-- We can alsom combine conditions using things like and or OR

SELECT name,milliseconds  FROM track
WHERE genre_id=3 AND milliseconds>100000
ORDER BY unit_price DESC LIMIT 10;

--AND both conditions must be met or one condition must be met
-- we can do pattern matching and some regex
SELECT  customer_id,first_name,last_name,email FROM customer
WHERE email LIKE '%@gmail.com'

--there are prebuilt sql functions we can use to manipulate data
-- the main two types are scalar and aggregate functinons


--saclar functions they opererate ona single bvalue and they retiurn on a singe valie
-- uppper lower
--length
--round 
-- aggregate functions operate over a set od values an dreturn a single value representing an attribute 
-- count sum avg min max

SELECT COUNT (*),AVG(milliseconds),MIN(unit_price),MAX(unit_price) FROM track;

-- we can create summary rows fror each genre id 
-- to see which genre has the most tracks we can do this using the group by 

SELECT genre_id,COUNT(*) AS track_count FROM track
GROUP BY genre_id
HAVING count(*)>50
ORDER BY track_count DESC;


-- JOINS ANS SUBQUERIES

--Lets say i want to return the album title and artist name of every album
SELECT  a.title as album, ar.name as artist
FROM album as a 
INNER JOIN artist as ar ON a.artist_id=ar.artist_id


--Left join
SELECT ar.name,a.title 
FROM artist ar
LEFT JOIN album a ON ar.artist_id=a.artist_id
WHERE ar.name LIKE 'A%';

--OUTER JOIN

--RETURNS ALL ROWS FROM BOTH THE TABLES MATCHES RECORDS WHERE NO MATCHES EXIST.ACCESS
-- eSSSENTIALLY THE COMPLAETE UNION OF BOTH THE TABLES 

SELECT ar.name,a.title
FROM artist ar
FULL OUTER JOIN album a ON ar.artist_id=a.artist_id
WHERE a.title IS NOT NULL;

--Cross JOINS 
EXPLAIN
SELECT g.name as genre,
mt.name as media_type
FROM genre g
CROSS JOIN media_type mt 
WHERE g.name IN ('Rock','Jazz')
Group BY g.name,mt.name;

--EQUI JOINS and theta joins 
--equi joins = any join thath use equality conditions in the ON clause 

SELECT 
     t1.name as track_name,
     t1.milliseconds as track_length,
     t2.avg_album_length
FROM track t1
INNER JOIN(
    SELECT album_id,AVG(milliseconds) 
    FROM track
    GROUP BY album_id
) as t2 ON t1.album_id=t2.album_id AND t1.milliseconds>t2.avg_album_length;

--SELF JOIN -Don't see it on the caricula but it is there just to practice
-- YOu just do a normal join you just do it 

--joining the employee table to itself
SELECT emp.first_name as employee,
       mgr.first_name as manager
FROM employee emp
LEFT JOIN employee mgr ON emp.reports_to=mgr.employee_id


--Sub queries quesrie within quesires we saw one in the inner join nust you can use inside where in or even inside a selsct 

SELECT name,milliseconds FROM track
WHERE milliseconds>(SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC LIMIT 10;

---- THE SUB QUESRY ALWAYS EVALUATES FRIST
SELECT name, unit_price,
(SELECT MAX(unit_price) FROM track) AS highest_price,
(SELECT MIN(unit_price) FROM track) AS lowest_price
FROM track
WHERE unit_price>(SELECT AVG(unit_price) FROM track)
