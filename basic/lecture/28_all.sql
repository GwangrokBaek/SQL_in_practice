-- 집합 연산자와 서브쿼리 - 07. All연산자
-- All 연산자는 값을 서브 쿼리에 의해 반환된 값 집합과 비교한다. All 연산자는 서브쿼리의 모든 값이 만족을 해야만 조건이 성립된다.

select
	title,
	length
from
	film f
where
	length >= all ( -- all이 없다면, any 때와 마찬가지로 group by에 의해 생긴 여러개의 집합과 비교해야하므로 SQL 문법 에러가 발생한다.
	select
		max(length)
	from
		film a,
		film_category b
	where
		a.film_id = b.film_id
	group by
		b.category_id )

-- 영화 카테고리별 상영시간이 가장 긴 영화의 모든 상영시간 보다 크거나 같아야만 조건이 성립한다. 영화 분류별 상영시간이 가장 긴 상영시간을 구한다.
----------------------------------------------

select
	film_id,
	title,
	length
from
	film f
where
	length > all (
	select
		round(avg(length), 2)
	from
		film f
	group by
		rating )
order by
	length

-- rating별 상영시간 평균값들보다 상영시간이 긴 영화들의 정보를 출력.