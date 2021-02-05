-- 데이터 조회와 필터링 - 08. BETWEEN 연산자 

select
	customer_id,
	payment_id,
	amount
from
	payment p
where
	amount between 8 and 9; -- 8 이상 9 이하의 집합을 출력. 
-- 아래 쿼리와 동일한 결과를 출력. 
---------------------------

select
	customer_id,
	payment_id,
	amount
from
	payment p
where
	amount >= 8
	and amount <= 9 ;
	
---------------------------

select
	customer_id,
	payment_id,
	amount
from
	payment p
where
	amount not between 8 and 9; -- 8 보다 작고 9 보다 큰 집합을 출력. 
-- 아래 쿼리와 동일한 결과를 출력. 
--------------------------

select
	customer_id,
	payment_id,
	amount
from
	payment p
where
	amount < 8
	or amount > 9;
	
--------------------------

select
	customer_id,
	payment_id,
	amount,
	payment_date
from
	payment p
where
	cast(payment_date as date) -- payment_date 가 time_stamp 타입이므로 이를 date 타입으로 바꿔주기 위해 cast 연산자 사용 
between '2007-02-07' and '2007-02-15';

---------------------------
select
	customer_id,
	payment_id,
	amount,
	payment_date
from
	payment p2
where
	to_char(payment_date, 'YYYY-MM-DD') -- to_char 연산자를 사용하면 지정한 형식의 char 타입으로 데이터 타입을 바꿔준다. 
between '2007-02-07' and '2007-02-15';
