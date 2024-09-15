
drop table if exists netflix;

create table Netflix 
(
	show_id varchar(6),
	type varchar(10),
	title varchar(150),
	director varchar(208),
	casts varchar(1000),
	country varchar(150),
	date_added varchar(50),
	release_year int,
	rating varchar(10),
	duration varchar(15),
	listed_in varchar(100),
	description varchar(250)
);
SELECT * FROM netflix;

SELECT COUNT(*) AS TOTAL_CONTENT FROM NETFLIX;

USE NETFLIX;

--15 Business Problems & Solutions

--1. Count the number of Movies vs TV Shows
select type,count(*) as total_content from netflix group by type;

--2. Find the most common rating for movies and TV shows
select type,rating,count(*),rank() over(partition by type order by count(*) desc) as ranking from netflix group by 1,2;

--3. List all movies released in a specific year (e.g., 2020)
select title,release_year from netflix where type ='Movie' and release_Year = 2020;

--4. Find the top 5 countries with the most content on Netflix
select unnest(string_to_array(country,',')) as new_country,count(show_id) as content_count from netflix group by 1 order by 2 desc limit 5;

--5. Identify the longest movie
select* from netflix where type='Movie' and duration=(select max(duration) from Netflix);

--6. Find content added in the last 5 years
select* FROM NETFLIX WHERE TO_DATE(date_added,'Month DD,YYYY') >= CURRENT_DATE - INTERVAL '5 YEARS';

--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select* from netflix;
select* from netflix where director ilike '%Rajiv Chilaka%';

--8. List all TV shows with more than 5 seasons
select
	*
from netflix
where
	type='TV Show' and
	SPLIT_PART(duration,' ',1)::numeric > 5;

--9. Count the number of content items in each genre
select listed_in,show_id,unnest(string_to_array(listed_in,',') from netflix;
select UNNEST(STRING_TO_ARRAY(listed_in,',')) as genre,COUNT(show_id) as genre_count
	from netflix GROUP BY 1;

--10.Find each year and the average numbers of content release in India on netflix. return top 5 year with highest avg content release!
select * from netflix;
SELECT 
	EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD,YYYY')) as year,
	count(*) as yearly_content,
	ROUND(count(*)::numeric/(SELECT COUNT(*) FROM netflix where country='India') * 100,2) as avg_content_per_year
FROM netflix
WHERE country='India' 
GROUP BY 1;

--11. List all movies that are documentaries
select * from netflix where LISTED_IN ILIKE '%documentaries%';

--12. Find all content without a director
select* from netflix where director is NULL;

--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select * from netflix where casts ilike '%salman khan%' and RELEASE_YEAR > EXTRACT(YEAR FROM CURRENT_DATE)-10;

--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select * from netflix;
select unnest(string_to_array(casts,',')) as actors,count(*) as total_content from netflix where country ilike '%india' group by 1 order by 2 desc limit 10;

--15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. 
__Label content containing these keywords as 'Bad' and all other content as 'Good'.
__Count how many items fall into each category.

select* from netflix where description ilike '%kill%' or description ilike '%violence%';
with new_table
AS
(
SELECT
*,
	CASE
	WHEN
		description ILIKE '%kill%' OR
		description ILIKE '%violence%' THEN 'Bad_Content'
		ELSE 'Good Content'
	END category
from netflix
)
select
	category,
	COUNT(*) AS total_content
FROM new_table
GROUP BY 1;
	

