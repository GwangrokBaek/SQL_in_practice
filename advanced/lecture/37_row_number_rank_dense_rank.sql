-- 조인과 집계 데이터 - 15. Row_number, Rank, Dense_rank 함수
-- 특정 집합 내에서 결과 건수의 변화 없이 해당 집합안에서 특정 컬럼의 순위를 구하는 함수이다.

-- row_number 함수는 같은 순위에 상관 없이 무조건 1, 2, 3, 4, 5 순서로 순차적으로 순위를 매긴다.

select
	a.product_name,
	b.group_name,
	a.price,
	row_number () over (partition by b.group_name -- 해당 집합내에서 순위를 구한다. 순위를 구할 때 partition by의 컬럼을 기준으로 구하고,
												  -- group_name 기준의 각 순위는 order by의 컬럼을 기준으로 정렬한다.
												  -- 이때 row_number는 같은 순위가 있어도 무조건 순차적으로 순위를 매긴다. (1, 2, 3, 4, 5 순으로 나간다.)
order by
	a.price desc)
from
	product a
inner join product_group b on
	a.group_id = b.group_id

-- rank 함수는 같은 순위면 동일 순위로 매기고 그 다음 순위로 건너뛴다. 1, 1, 3, 4

select
	a.product_name,
	b.group_name,
	a.price,
	rank () over (partition by b.group_name -- 기준은 row_number 함수와 동일.
order by
	a.price desc)
from
	product a
inner join product_group b on
	a.group_id = b.group_id

-- dense_rank 함수는 같은 순위면 동일 순위로 매기고 그 다음 순위로 건너뛰지 않는다. 1, 1, 2, 3

select
	a.product_name,
	b.group_name,
	a.price,
	dense_rank () over (partition by b.group_name -- 기준은 row_number 함수와 동일.
order by
	a.price desc)
from
	product a
inner join product_group b on
	a.group_id = b.group_id