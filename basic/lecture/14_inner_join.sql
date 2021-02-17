-- 조인과 집계 데이터 - 02. INNER 조인

-- inner join 은 수학적 의미로 교집합이다.
-- 특정 컬럼을 기준으로 정확히 매칭된 집합을 출력.
-- ER 다이어그램을 활용해서 데이터들간의 논리적 관계를 표현할 수 있다.

select
	ba.id id_a,
	ba.fruit fruit_a,
	bb.id id_b,
	bb.fruit fruit_b
from
	basket_a ba
inner join basket_b bb on
	ba.fruit = bb.fruit
	
-- fruit 컬럼을 기준으로 basket_a 테이블과 basket_b 테이블을 결합하여 결과 출력.

---------------------------------------
	
select
	c.customer_id ,
	c.first_name ,
	c.last_name ,
	c.email ,
	p.amount ,
	p.payment_date
from
	customer c
inner join payment p on
	c.customer_id = p.customer_id

select
	count(*)
from
	customer
	
select
	count(*)
from
	payment
	
-- customer의 count가 599인데 inner join 문의 count가 14,596이 될 수 있는 이유는
-- payment의 count가 14,596으로 고객이 여러건의 결제를 할 수 있는 즉, 고객1:결제M -> 1:M 관계이기 때문.

-----------------------------------------

select
	c.customer_id ,
	c.first_name ,
	c.last_name ,
	c.email ,
	p.amount ,
	p.payment_date
from
	customer c
inner join payment p on
	c.customer_id = p.customer_id
where
	c.customer_id = 2

-- inner join에 where 사용.
------------------------------------------

select
	c.customer_id ,
	c.first_name ,
	c.last_name ,
	c.email ,
	p.amount ,
	p.payment_date ,
	s.first_name as s_first_name,
	s.last_name as s_last_name
from
	customer c
inner join payment p on
	c.customer_id = p.customer_id
inner join staff s on
	p.staff_id = s.staff_id

-- inner join 2개 사용.
-- 고객1:결제M:직원1 관계여서 14,596개 출력.
-------------------------------------------