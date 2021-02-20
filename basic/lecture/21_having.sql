-- 조인과 집계 데이터 - 09. Having 절 
-- Group by 절과 함께 Having 절을 사용하여 Group by의 결과를 특정 조건으로 필터링 하는 기능 수행.

-- 즉, where 절은 Group by 절이 적용되기 전에 개별 행의 조건을 설정하고,
-- Having 절은 Group by 절에 의해 생성된 그룹행의 조건을 설정. 이때 Having 절은 group by 절의 기준 컬럼이 아닌, 다른 컬럼에 대해서 조건문 작성이 가능하다.
-- 대신, 다른 컬럼에 대해서 조건문을 작성할 경우에는 집계 함수를 사용해주어야 한다.

select
	customer_id,
	sum(p.amount) as amount_sum
from
	payment p
group by
	customer_id
having
	sum(amount) > 200

------------------------------------

select
	a.customer_id,
	b.email,
	sum(a.amount) as amount_sum
from
	payment a,
	customer b -- email 정보 추출해주기 위해 customer 테이블 inner join 수행.
where
	a.customer_id = b.customer_id
group by
	a.customer_id ,
	b.email -- 위 select에서 customer 테이블의 email 정보도 출력하기 위해 group by 절에 b.email 추가.
			-- 중복되는 email을 제거.
having
	sum(a.amount) > 200

-------------------------------------

select
	store_id,
	count(customer_id) as count
from
	customer c
group by
	store_id
having
	count(customer_id) > 300
	
-- group by 와 having 절은 매우 많이 사용된다.
