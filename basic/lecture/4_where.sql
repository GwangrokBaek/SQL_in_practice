-- 데이터 조회와 필터링 4. where 절
-- 같음은 = 하나로 표기하고, ~가 아닌은 <> 또는 != 로 표기할 수 있다.

select
	last_name, -- 3
 	first_name
from
	customer -- 1
where
	first_name = 'Jamie' -- 2
;
-- 1번 - 2번 -3 번 순으로 실행된다.
--------------------------------
select
	last_name,
	first_name
from
	customer
where
	first_name = 'Jamie'
	and last_name = 'Rice' ;

-- ctrl + shift + F 를 하면 DBeaver가 스크립트 정렬을 해준다.

----------------------------------
select *
from payment
;

select
	customer_id ,
	amount ,
	payment_date
from
	payment
where
	amount <= 1
	or amount >= 8
;
