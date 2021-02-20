-- 집합 연산자와 서브쿼리 - 10. 실습문제-2
-- 아래 SQL문은 Except 연산을 사용하여 재고가 없는 영화를 구하고 있다. 해당 SQL 문을 Except 연산을 사용하지 않고 같은 결과를 도출하라.

select
	film_id,
	title
from
	film
except
select
	distinct inventory.film_id,
	title
from
	inventory
inner join film on
	film.film_id = inventory.film_id
order by
	title

-------------------------------------

select
	film_id,
	title
from
	film f
where
	not exists (
	select
		1
	from
		inventory i
	where
		f.film_id = i.film_id )
order by
	title