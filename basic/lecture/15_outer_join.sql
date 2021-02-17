-- 조인과 집계 데이터 - 03. OUTER 조인 

-- 특정 컬럼을 기준으로 매칭된 집합을 출력하지만 한쪽의 집합은 모두 출력하고 다른 한쪽의 집합은
-- 매칭되는 컬럼의 값 만을 출력.
-- 즉, 테이블을 결합해서 결과를 출력할때 일치하지 않는 레코드도 유지하면서 데이터를 출력.

select
	ba.id as id_a,
	ba.fruit as fruit_a,
	bb.id as id_b,
	bb.fruit as fruit_b
from
	basket_a ba
left outer join basket_b bb on -- outer 생략 가능.
	ba.fruit = bb.fruit
	
-------------------------------
	
select
	ba.id as id_a,
	ba.fruit as fruit_a,
	bb.id as id_b,
	bb.fruit as fruit_b
from
	basket_a ba
left join basket_b bb on
	ba.fruit = bb.fruit
where
	bb.id is null -- left only join. null문 체크를 이용해서 교집합을 제외하고 왼쪽에 있는 값만 출력가능.
	
-------------------------------

select
	ba.id as id_a,
	ba.fruit as fruit_a,
	bb.id as id_b,
	bb.fruit as fruit_b
from
	basket_a ba
right outer join basket_b bb on
	ba.fruit = bb.fruit 
	
-------------------------------
	
select
	ba.id as id_a,
	ba.fruit as fruit_a,
	bb.id as id_b,
	bb.fruit as fruit_b
from
	basket_a ba
right outer join basket_b bb on
	ba.fruit = bb.fruit
where
	ba.id is null -- right only join. null문 체크를 이용해서 교집합을 제외하고 오른쪽에 있는 값만 출력.

-------------------------------
	
-- left, right outer join은 실무에서 많이 쓰인다. 예를 들어 기준집합 중에서 고객의 데이터를 보고 싶을때 계약 유무에 상관없이
-- 고객의 데이터를 보고 싶지만, 계약의 유무도 함께 보여주면 더 좋을때 left, right outer join을 주로 사용.