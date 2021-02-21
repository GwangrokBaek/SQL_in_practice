-- 조인과 집계 데이터 17. Lag, Lead 함수
-- 특정 집합 내에서 결과 건수의 변화 없이 해당 집합안에서 특정 컬럼의 이전 행의 값 혹은 다음 행의 값을 구한다. lag 함수와 lead 함수는 매우 많이 사용된다.

-- lag 함수는 이전 행의 값을 찾는다. lag 함수 안의 숫자는 몇 번째 이전의 행을 찾을지를 정해준다.

select
	a.product_name,
	b.group_name,
	a.price,
	lag (a.price, 1) over (partition by b.group_name order by a.price) as prev_price,
	-- partition by 컬럼을 기준으로 order by 컬럼으로 정렬한 값 중에서 price의 이전 행의 값을 구한다.
	a.price - lag(price, 1) over (partition by group_name order by a.price) as cur_prev_diff
	-- partition by 컬럼을 기준으로 order by 컬럼으로 정렬한 값 중에서 현재 행의 price에서 이전 행의 price를 뺀다.
from
	product a
inner join product_group b on
	a.group_id = b.group_id

-- lead 함수는 다음 행의 값을 찾는다. lead 함수 안의 숫자는 몇 번째 다음 행을 찾을지를 정해준다.

select
	a.product_name,
	b.group_name,
	a.price,
	lead (a.price, 1) over (partition by b.group_name order by a.price) as prev_price,
	-- partition by 컬럼을 기준으로 order by 컬럼으로 정렬한 값 중에서 price의 다음 행의 값을 구한다.
	a.price - lead(price, 1) over (partition by group_name order by a.price) as cur_prev_diff
	-- partition by 컬럼을 기준으로 order by 컬럼으로 정렬한 값 중에서 현재 행의 price에서 다음 행의 price를 뺀다.
from
	product a
inner join product_group b on
	a.group_id = b.group_id