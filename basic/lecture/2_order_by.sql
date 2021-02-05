-- 데이터 조회와 필터링 - 2. order by 문
select first_name,
last_name
from customer
order by first_name asc
;
--------------------------
select first_name,
last_name
from customer
order by first_name desc
;
---------------------------
select first_name,
last_name
from customer
order by first_name asc,
		 last_name desc;
-- 첫 번째 속성에 대해서 오름차순으로 정렬 후, 같은 속성에 대해서 두 번째 속성 내림차순 정
---------------------------
select
	first_name
	, last_name
from 
	customer
order by 1 asc,
		2 desc;
-- 1과 2로 select에서 사용된 열을 가리킬 수 있다. 간편하지만 가독성이 떨어진다.