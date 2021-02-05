-- 데이터 조회와 필터링 - 05. LIMIT 절 

select
	film_id,
	title,
	release_year
from
	film
order by
	film_id -- order by 한 결과에
limit 5 ; -- 상위 5개만 출력

-----------------------------------------

select
	film_id,
	title,
	release_year
from
	film f2
order by
	film_id
limit 4 offset 3 ; -- 시작 위치 3부터 출력. 시작 위치는 0부터 시작하므로 즉 4번째 행부터 출력  

-----------------------------------------

select
	film_id,
	title,
	rental_rate
from
	film f
order by
	rental_rate desc
limit 100 offset 5 ;
-- 0 1 2 3 4 5
-- 1 2 3 4 5 6 6 번째 행부터 출력
-- limit 절은 쇼핑몰 뿐만 아니라, 많은 곳에서 사용하므로 매우 중요. 만약 몇 천만개의 데이터가 있을 때
-- limit 절 없이 출력하면 오류 발생 
