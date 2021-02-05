-- 데이터 조회와 필터링 -11. 실습 문제-1

-- payment 테이블에서 단일 거래의 amount의 액수가 가장 많은 고객들의 customer_id를 추출하라. 단, customer_id의 값은 유일해야 한다.

select
	distinct customer_id
from
	payment
where
	amount in (
	select
		amount
	from
		payment
	order by
		1 desc
	limit 1 )