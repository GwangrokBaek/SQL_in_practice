-- 집합 연산자와 서브쿼리 - 05. 서브쿼리란
-- 서브쿼리는 SQL문 내에서 메인 쿼리가 아닌 하위에 존재하는 쿼리를 말한다.
-- 서브쿼리를 활용함으로써 다양한 결과를 도출 할 수 있다.

select
	avg(rental_rate)
from
	film f
-- 2.98

select
	film_id,
	title,
	rental_date
from
	film f
where
	rental_rate > 2.98
	
-- 서브쿼리를 사용해 위 2개의 SQL을 결합하여 하나의 SQL문으로 결과를 도출할 수 있다.
-- 중첩 서브쿼리, 인라인 뷰, 스칼라 서브쿼리 등을 사용해 가능하다. <- 서브쿼리의 종류.
---------------------------------
-- 위 2개의 쿼리를 아래처럼 중첩 서브 쿼리를 사용해서 1개의 SQL 문으로 합칠 수 있다.
-- where 절 안에 괄호를 열어서 서브 쿼리를 생성하는 것을 중첩 서브 쿼리라고 한다.

select
	film_id,
	title,
	rental_rate
from
	film f
where
	rental_rate > ( -- 중첩 서브쿼리 시작.
	select
		avg(rental_rate)
	from
		film ) -- 중첩 서브쿼리 종료.
----------------------------------
-- from 절 안에 괄호를 열어서 서브 쿼리를 생성하는 것을 인라인 뷰라고 한다.

select
	a.film_id,
	a.title,
	a.rental_rate
from
	film a,
	( -- 인라인 뷰 시작.
	select
		avg(rental_rate) as avg_rental_rate
	from
		film ) b -- 인라인 뷰 종료.
where
	a.rental_rate > b.avg_rental_rate
------------------------------------
-- select 절 안에 괄호를 열어서 서브 쿼리를 생성하는 것을 스칼라 서브쿼리라고 한다.

select
	a.film_id,
	a.title,
	a.rental_rate
from
	( -- 인라인 뷰 시작.
	select
		a.film_id,
		a.title,
		a.rental_rate,
		( -- 스칼라 서브쿼리 시작.
		select
			avg(l.rental_rate)
		from
			film l ) as avg_rental_rate -- 스칼라 서브쿼리 종료.
	from
		film a ) a -- 인라인 뷰 종료.
where
	a.rental_rate > a.avg_rental_rate
--------------------------------------
-- 위 중첩 서브쿼리, 인라인 뷰, 인라인 뷰 + 스칼라 서브쿼리는 동일한 결과를 출력하지만, 성능면에서 뭐가 좋은지는 알 수가 없다.
-- 왜냐하면 optimizer가 최적화를 수행해주기 때문에 알 수 없음.

