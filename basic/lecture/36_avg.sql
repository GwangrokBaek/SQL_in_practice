-- 조인과 집계 데이터 - 14. Avg 함수
-- 분석함수 Avg() 부터 본격적으로 분석함수를 학습한다. 이때 avg 함수는 특정 집합 내에서 결과 건수의 변화 없이 해당 집한안에서 특정 컬럼의 평균을 구하는 함수이다.
-- 분석함수는 사용하고자 하는 분석함수를 쓰고 대상 컬럼을 기재 후 partition by 에서 값을 구하는 기준 컬럼을 쓰고, order by 에서 정렬 컬럼을 기재한다.

select
	c1,
	분석함수(c2, c3, ...) over (partition by c4 order by c5)
from
	table_name

---------------------------------

select
	avg(price) -- 이때 집계 함수만 사용되었으므로 집계의 결과만 출력. price 컬럼의 평균값을 구한다.
from
	product

---------------------------------

select
	b.group_name,
	avg (price) -- group_name 컬럼을 기준으로 price 컬럼의 평균값을 구한다.
from
	product a
inner join product_group b on
	a.group_id = b.group_id
group by
	b.group_name

---------------------------------

select
	a.product_name,
	a.price,
	b.group_name,
	avg(a.price) over (partition by b.group_name) -- over()를 붙여 분석 함수가 사용되었다. 따라서 group_name 컬럼을 기준으로 price의 평균값을 출력하면서 나머지 데이터들도 출력해준다.
from
	product a
inner join product_group b on
	a.group_id = b.group_id

----------------------------------

select
	a.product_name,
	a.price,
	b.group_name,
	avg(a.price) over (partition by b.group_name order by b.group_name) 
from
	product a
inner join product_group b on
	a.group_id = b.group_id

-----------------------------------

select
	a.product_name,
	a.price,
	b.group_name,
	avg(a.price) over (partition by b.group_name order by a.price) -- order by에 partition by에 사용된 컬럼이 아닌 다른 컬럼을 기재해주면 partition 별로 누적 집계 (평균) 를 해준다.
																   -- 따라서 각 partition의 마지막에 위치해 있는 데이터에 partition 전체의 집계 (평균) 를 보여준다.
from
	product a
inner join product_group b on
	a.group_id = b.group_id