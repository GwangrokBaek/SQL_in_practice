-- 데이터 조회와 필터링 - 06. FETCH 절

select
	film_id,
	title
from
	film f
order by
	title
fetch first row only -- fetch first와 row only 사이에 숫자를 기입하지 않을 시, 단 한 건만 조회

-- 한 건만 출력하는 것은 생각보다많이 사용된다. 예를 들어 이메일에서 메일을 가져올 때 모든 메일을 가져오는 것이 아니라,
-- 가장 최근의 메일 단 한건만 가져오는 경우 등.

----------------------------------------

select
	film_id,
	title
from
	film f
order by
	title
fetch first 3 row only -- 지정한 숫자만큼 출력

----------------------------------------

select
	film_id,
	title
from
	film f
order by
	title
offset 5 rows -- 0 1 2 3 4 5 부터 출력하게끔 지정 (즉, 6번째 행부터 출력) 
fetch first 5 row only

-- limit 절과 fetch 절 중 어느것을 쓰더라도 무방 
