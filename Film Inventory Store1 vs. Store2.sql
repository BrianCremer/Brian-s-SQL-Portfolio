--PostgreSQL query that shows the film ids that have more copies in inventory in store 1 than store 2.
select st1.film_id,st2.film_id
	,st1.number_of_copies as st1_number_of_copies
	,st2.number_of_copies as st2_number_of_copies
from
	(select film_id,count(1) number_of_copies
	 from inventory 
	 where store_id=1 
	 group by 1) st1
left join
			(select film_id
				,count(1) number_of_copies
			from inventory 
			where store_id=2 
			group by 1) st2 on st1.film_id=st2.film_id
where st1.number_of_copies > coalesce(st2.number_of_copies,0)