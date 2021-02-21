-- 조인과 집계 데이터 - 16. First_value, Last_value 함수
-- 특정 집합 내에서 결과 건수의 변화 없이 해당 집합 안에서 특정 컬럼의 첫 번째 값 혹은 마지막 값을 구하는 함수이다.

-- first_value ()

select
	a.product_name,
	b.group_name,
	a.price,
	first_value (a.price) over (partition by b.group_name
order by
	a.price) as lowest_price_per_group -- partition by 컬럼을 기준으로 order by 컬럼으로 정렬한 값 중, 가장 첫 번째에 나오는 price 값을 출력한다.
from
	product a
inner join product_group b on
	a.group_id = b.group_id

--------------------------------------------

-- last_value ()

select
	a.product_name,
	b.group_name,
	a.price,
	last_value (a.price) over (partition by b.group_name
order by
	a.price range between unbounded preceding and unbounded following) as lowest_price_per_group
	-- partition by 컬럼을 기준으로 order by 컬럼으로 정렬한 값 중에서 파티션의 첫 번째 로우부터 파티션의 마지막 로우까지 중 가장 마지막에 나오는 price 값을 출력한다.
from
	product a
inner join product_group b on
	a.group_id = b.group_id

-- last_value 함수에서 범위의 default 값은 range between unbounded preceding and current row 이다.
-- current row는 현재 행까지를 의미하므로 행 하나만 출력하게 된다.