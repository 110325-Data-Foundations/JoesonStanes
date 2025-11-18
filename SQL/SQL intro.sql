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
