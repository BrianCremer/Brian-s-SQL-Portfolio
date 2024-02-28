-- Postgres SQL query that selects the top 5 museums with the highest proportion of cubist style paintings.
select museum.name
	,round(avg(case when style = 'Cubism' then 1 else 0 end),2)
from work
inner join museum on work.museum_id = museum.museum_id
group by 1
order by 2 desc
limit 5;


