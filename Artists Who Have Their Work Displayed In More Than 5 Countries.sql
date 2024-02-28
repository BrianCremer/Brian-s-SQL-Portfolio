--PostgreSQL query that shows which artists have their work displayed in museums in many different countries.

select artist.full_name
	,count(distinct country) as number_of_countries from artist
inner join work on artist.artist_id = work.artist_id
inner join museum on work.museum_id = museum.museum_id
group by 1
order by 2 desc
limit 6;
