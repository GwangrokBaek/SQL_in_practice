-- 집합 연산자와 서브쿼리 - 06. Any연산자
-- Any 연산자는 값을 서브 쿼리에 의해 반환된 값 집합과 비교한다. Any 연산자는 서브쿼리의 값이 어떠한 값이라도 만족을 하면 조건이 성립된다.

select
	title,
	length
from
	film f
where
	length >= any ( -- 만약에 any가 없다면 SQL 문법 에러가 발생하는데, 왜냐하면 length와 비교하는 집합이 단 한 건이어야 하는데,
				   -- group by에 의해 카테고리 개수만큼 집합이 생성되기 때문에 16개의 집합이 나오기 때문이다.
				   -- 이때 length 와 >= 연산자로 16개의 집합을 비교하는 경우, 16개 중 무엇과 비교해야할지 모르기때문에 에러 발생.
				   -- 따라서 any 연산자를 사용해서 16개의 집합 중 어떠한 값이라도 만족을 하면 조건이 성립된다는 조건을 추가해준다.
	select
		max(length)
	from
		film a,
		film_category b
	where
		a.film_id = b.film_id
	group by
		b.category_id )

-- 영화 카테고리별 상영시간이 가장 긴 상영시간과 동일한 상영시간을 갖는 영화의 제목을 출력한다.
-- 이때 영화 분류별 상영시간이 가장 긴 상영시간을 구한다.
---------------------------------------------

select
	title,
	length
from
	film f
where
	length = any ( -- 이때 = any의 경우, in 연산자와 동일하다.
	select
		max(length)
	from
		film a,
		film_category b
	where
		a.film_id = b.film_id
	group by
		b.category_id )

----------------------------------------------
-- 위 = any 연산자는 in 연산자와 동일하다.

select
	title,
	length
from
	film f
where
	length in (
	select
		max(length)
	from
		film a,
		film_category b
	where
		a.film_id = b.film_id
	group by
		b.category_id )