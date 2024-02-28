-- PostgreSQL query that selects the names of actors that have been in more films than average
select film_actor.actor_id,first_name,last_name,count(1) film_count
from film_actor
inner join actor on film_actor.actor_id = actor.actor_id
group by 1,2,3
having count(1) > (
		select avg(film_count) avg_films_per_actor from (
			select actor_id,count(1) film_count from film_actor group by 1
		) film_actor
);