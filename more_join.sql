-- List the films where the yr is 1962 [Show id, title]
SELECT id, title FROM movie WHERE yr=1962

--  Give year of 'Citizen Kane'.
select yr from movie where title = 'Citizen Kane'

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
select id,title,yr from movie where title LIKE '%Star Trek%'

-- What id number does the actor 'Glenn Close' have?
select id from actor where name = 'Glenn Close'

-- What is the id of the film 'Casablanca'
select id from movie where title = 'Casablanca'

-- Use movieid=11768, (or whatever value you got from the previous question)
select actor.name from casting
join actor on actorid = id
where movieid = 11768

-- Obtain the cast list for the film 'Alien'
select actor.name from casting join actor
on actorid = id
where movieid = (select id from movie where title = 'Alien')

-- List the films in which 'Harrison Ford' has appeared
select title from movie join casting
on movie.id = casting.movieid
where casting.actorid = (select id from actor where name = 'Harrison Ford')

-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
select title from movie join casting
on movie.id = casting.movieid
where casting.actorid = (select id from actor where name = 'Harrison Ford') and casting.ord <>1

-- List the films together with the leading star for all 1962 films.
select movie.title, actor.name from movie 
join casting on movie.id = casting.movieid
join actor on casting.actorid = actor.id

where movie.yr = 1962 and casting.ord=1

-- Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 where name='John Travolta'
 GROUP BY yr) AS t
)

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name
  FROM movie JOIN casting ON (movieid = movie.id                             
   AND ord=1)
    JOIN actor ON (actorid = actor.id)
  WHERE movie.id IN (
        SELECT movieid FROM casting
         WHERE actorid IN (
            SELECT id FROM actor
             WHERE name = 'Julie Andrews'))   

-- Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT name FROM actor
  JOIN casting ON (id = actorid AND (SELECT COUNT(ord) FROM casting WHERE actorid = actor.id AND ord=1)>=30)
GROUP BY name

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(actorid) AS cast FROM movie 
JOIN casting ON id = movieid
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC,title

-- List all the people who have worked with 'Art Garfunkel'.
SELECT DISTINCT name FROM actor 
JOIN casting ON id=actorid
WHERE movieid IN (SELECT movieid FROM casting 
JOIN actor ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel'
GROUP BY name