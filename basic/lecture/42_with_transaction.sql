-- 조건 연산자, With문, 트랜잭션 - 05. With 문의 활용
-- with 문을 활용함으로써 select 문의 결과를 임시 집합으로 저장해두고 SQL 문에서 마치 테이블 처럼 해당 집합을 불러올 수 있다.

select
	film_id,
	title,
	(case
		when length < 30 then 'SHORT'
		when length >= 30
		and length < 90 then 'MEDIUM'
		when length > 90 then 'LONG'
	end) length
from
	film

---------------------------------------

with tmp1 as ( -- with 문을 이용해서 해당 집합을 tmp1 으로 지정하고 아래 select 문에서 tmp1 을 조회할 수 있다.
select
	film_id,
	title,
	(case
		when length < 30 then 'SHORT'
		when length >= 30
		and length < 90 then 'MEDIUM'
		when length > 90 then 'LONG'
	end) length
from
	film )
select
	*
from
	tmp1 a

----------------------------------------

with tmp1 as ( -- tmp1 집합에서 상영시간 구분이 long인 집합을 출력하는 등 where 절 또한 사용할 수 있다.
select
	film_id,
	title,
	(case
		when length < 30 then 'SHORT'
		when length >= 30
		and length < 90 then 'MEDIUM'
		when length > 90 then 'LONG'
	end) length
from
	film )
select
	*
from
	tmp1 a
where
	length = 'LONG'