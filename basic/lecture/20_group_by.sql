-- 조인과 집계 데이터 - 08. Group By 절
-- Group by 절은 select 문에서 반환된 행을 그룹으로 나눈다. 각 그룹에 대한 합계, 평균, 카운트 등을 계산할 수 있다.
-- Group by 에 사용된 컬럼이 기준이 되는데, 해당 컬럼을 select에서 사용 가능. 이때 기준 컬럼이 아닌 다른 컬럼에 대해서는 그냥은 사용하지 못하고,
-- count, sum과 같이 집계 함수를 통해서 다른 컬럼 사용 가능. 왜냐하면 group by의 기준 컬럼으로 논리적 테이블이 그룹핑되어 재구성되었기 때문.

select
	customer_id
from
	payment p
group by
	customer_id -- group by를 통해 각 레코드를 customer_id를 기준으로 그룹으로 나누므로
				-- customer_id를 기준으로 중복이 제거된 데이터를 출력한다. 

-- 아래 distinct를 사용한 것과 동일한 결과를 출력.
------------------------------

select
	distinct customer_id
from
	payment p

------------------------------
	
-- 거래액이 가장 많은 고객순으로 출력.

select
	customer_id,
	sum(amount) as amount_sum
from
	payment p
group by
	customer_id
order by
	sum(amount) desc

-------------------------------

-- 그리고 거래액이 가장 많은 고객의 정보를 확인.

select
	*
from
	customer
where
	customer_id = 148

-------------------------------

select
	staff_id, 
	count(staff_id) as count
from
	payment p
group by
	staff_id

--------------------------------

select
	*
from
	staff s
where
	staff_id = 1
	
---------------------------------

select
	p.staff_id ,
	b.staff_id ,
	b.first_name ,
	b.last_name ,
	count(p.staff_id) as count
from
	payment p ,
	staff b
	-- join 문 사용.

	where p.staff_id = b.staff_id
group by
	p.staff_id , -- group by를 사용했을때 select에서 더 많은 데이터를 출력하기 위해서는 다른 데이터에 대해서도 group을 생성해줘야지 출력 가능.
	b.staff_id , -- 이때 group by 는 중복을 제거하므로 staff_id, first_name, last_name 중에서 중복이 있는 데이터들을 제거하고 하나의 데이터만 출력.
	b.first_name ,
	b.last_name