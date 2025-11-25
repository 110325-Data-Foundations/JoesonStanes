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



-- DAY 2 --

-- yester day we went through beginner to intermediate sql concepts
-- We  are gonna start with transactions and tcl commands we have complex operations we want to affect the data bse we want to ensure that all comands execute or all changes are executed 


--A-THis can be broken down any further all pars of out transcation must suceeed or they fail
--C-- The database moves from one state to another state
--I-Isolations:Transactions can interfere or step on one another 
--Durability-Once a transactions is commited the chages are permanent 

--Lets transffer a track between playlist 

BEGIN TRANSACTION;

--remove the track from one play list add the track on an another playlist 
-- lets verify for illustrative  purposes our changes before we commit
DELETE FROM playlist_track --some light dml deleting a record from a table
WHERE playlist_id=1 AND track_id=1;
-- because this table has a composite priamary key we need to specify both key columns to selsct one unique row
INSERT INTO playlist_track (playlist_id,track_id)
VALUES (2,1);

SELECT * FROM playlist_track
WHERE track_id=1 AND  playlist_id IN (1,2);
--Transactions can involve many many operations that can involve some applications that can fail
--to add save points and places where if an error is detecte

COMMIT;-- THis makes the chages to the data bse always end the transaction with a commit

ROLLBACK TO deleted_track;-- this will roll back to a specific save point
ROLLBACK;

--Indexes

-- Indexes in sql  islike indexes in a book, they help you find data faster.ACCESS
-- they are special lookup tables that the database search engine can use to speed up data retrieval
EXPLAIN -- Use EXPLAIN ANALYZE to diagnose query performance
EXPLAIN ANALYZE
SELECT * FROM  track where composer LIKE '%John%';


--Lets create index to speed up composer searches 
CREATE INDEX idx_composer ON track (composer);


CREATE INDEX idx_invoice_customer_data ON invoice(customer_id,total);
EXPLAIN ANALYSE
SELECT * FROM invoice 
WHERE customer_id=1 AND total>5;

--Views 

--Views are virtual tables based on saved quesiresWe can  then reuse the  result 
CREATE OR REPLACE VIEW rock_tracks_view AS
SELECT 
     t.track_id,
     t.name AS track_name,
     a.title AS album_title,
     ar.name as artist_name,
     t.milliseconds,
     t.unit_price
FROM track t
JOIN album a ON t.album_id=a.album_id
JOIN artist ar ON a.artist_id=ar.artist_id
join genre g ON t.genre_id = g.genre_id
WHERE g.name='Rock'

SELECT * FROM rock_tracks_view
WHERE album_title LIKE '%Restless and Wild%'
ROLLBACK;
--Lets create a stored procedure
CREATE OR REPLACE PROCEDURE update_track_price(
    genre_name TEXT,
    price_increase_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
      UPDATE track
      SET unit_price = unit_price * (1 + price_increase_percent / 100)
      WHERE genre_id = (SELECT genre_id FROM genre WHERE name = genre_name);

     RAISE NOTICE 'Updated prices for genre: %, increased by % percent', genre_name,price_increase_percent;

END;
$$;



SELECT track_name,unit_price FROM rock_tracks_view
CALL update_track_price('Rock',10);


ROLLBACK;
--lets create a function to create a single value back thsi case how much a user spent at out music store
CREATE OR REPLACE FUNCTION get_customer_total_spent(
    custome_idp INTEGER) 
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    total_spent NUMERIC; -- declaring any variables total will hold some values like total amount spent 
BEGIN
     SELECT SUM(total) INTO total_spent
     FROM invoice
     WHERE customer_id = customer_idp;
     
     RETURN total_spent;


--notice we use return up top,but just return


END;
$$;

--IF WE WANT TO USE A FUNCTION AS ANUY OTHER FUNCTION LIKE SELECTING THE COUNT AS PART OF THE QUERRY
SELECT first_name,get_customer_total_spent(1)     AS total_spent
FROM customer;




---DATABSE ADMIN-A sored procedure or a databse that happens automatically whe a specific event occures
--Triggers can be set up to automatically run on things like INSERT UPDATE DELETE etc
--can be used for logging task automation and things like that 